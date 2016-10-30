require_relative 'card_deck'
require_relative 'rules'

module BlackJack
  class Dealer
    attr_reader :cards, :card_deck

    def initialize
      @cards = []
      @card_deck = CardDeck.new
      @card_deck.shuffle
    end

    def deal_card
      @card_deck.upper_card
    end

    def sums_cards
      @cards.map(&:points).inject do |sums, points|
        sums.product(points).map { |sum_points| sum_points.inject(:+) }
      end.uniq.select { |sum| sum <= 21 }
    end

    def give_win(situation, bet)
      bet * Rules::BET[situation]
    end
  end
end
