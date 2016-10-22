require_relative 'card'

module BlackJack
  class CardDeck
    NAMES = %w(2 3 4 5 6 7 8 9 10 J D K A).freeze
    SUITS = %w(b s d h).freeze
    attr_reader :cards

    def initialize
      @cards = create_card_deck
    end

    def upper_card
      @cards.shift
    end

    def lower_card
      @cards.pop
    end

    def shuffle
      @cards.shuffle!
    end

    def number_of
      @cards.size
    end

    def empty?
      @cards.empty?
    end

    private

    def create_card_deck
      SUITS.each_with_object([]) do |suit, deck|
        NAMES.zip([suit] * NAMES.length) do |card|
          point = case card[0]
                  when 'J', 'D', 'K' then [10]
                  when 'A' then [11, 1]
                  else
                    [card[0].to_i]
                  end
          deck << Card.new(card.join, point)
        end
      end
    end
  end
end

s = BlackJack::CardDeck.new
print s.cards
