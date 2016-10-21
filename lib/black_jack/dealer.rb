module BlackJack
  class Dealer
    attr_reader :cards, :card_deck

    def initialize
      @cards = []
      @card_deck = create_card_deck
    end
  end
end
