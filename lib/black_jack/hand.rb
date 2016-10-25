module BlackJack
  class Hand
    attr_reader :cards, :bet

    def initialize
      @cards = []
      @bet = nil
    end

    def show_cards
      @cards.map(&:name)
    end

    def sums_of_cards
      @cards.map { |card| card.points.size == 1 ? card.points * 2 : card.points }
            .transpose
            .map { |points| points.inject(:+) }
            .select { |sum| sum >= 21 }
    end

    def add_card(card)
      @cards << card
    end

    def add_bet(bet)
      @bet = bet
    end
  end
end
