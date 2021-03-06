require_relative 'rules'

module BlackJack
  class Hand
    attr_reader :cards, :bet
    attr_accessor :splitted, :black_jack, :win

    def initialize(cards =  [], splitted = false)
      @cards = cards
      @bet = nil
      @double = false
      @splitted = splitted
    end

    def cards_names
      @cards.map(&:name)
    end

    def cards_sums
      @cards.map(&:points).inject do |sums, points|
        sums.product(points).map { |sum_points| sum_points.inject(:+) }
      end
    end

    def max_valid_sum
      cards_sums.select { |sum| sum <= Rules::BLACK_JACK }.max
    end

    def min_sum
      cards_sums.min
    end

    def add_card(card)
      @cards << card
    end

    def add_bet(bet)
      @bet = bet
    end

    def black_jack?
      cards_sums.any? { |sum| sum == Rules::BLACK_JACK }
    end

    def split?
      return false if cards.size > 2
      cards.first.points == cards.last.points
    end

    def give_last_card
      @cards.pop
    end

    def double
      @double = true
      @bet *= 2
    end

    def double?
      return false if @double
      return true if @splitted
      cards_sums.any? { |sum| Rules::DOUBLE_SUM.include?(sum) }
    end

    def loose?
      cards_sums.min > 21
    end

    def bust?
      max_valid_sum ? false : true
    end
  end
end
