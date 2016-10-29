require_relative 'rules/rules'

module BlackJack
  class Hand
    attr_reader :cards, :bet

    def initialize(cards =  [])
      @cards = cards
      @bet = nil
    end

    def cards_names
      @cards.map(&:name)
    end

    def cards_sums
      @cards.map(&:points).inject do |sums, points|
        sums.product(points).map { |sum_points| sum_points.inject(:+) }
      end
    end

    def max_sum
      cards_sums.max
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
  end
end
