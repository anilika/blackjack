module BlackJack
  class Hand
    def initialize
      @cards = []
      @rate = nil
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
  end
end
