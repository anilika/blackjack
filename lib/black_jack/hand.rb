require_relative 'rules/rules'

module BlackJack
  class Hand
    attr_reader :cards, :bet

    def initialize
      @cards = []
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
      print cards_sums
      print @cards
      cards_sums.any? { |sum| sum == Rules::BLACK_JACK }
    end
  end
end
