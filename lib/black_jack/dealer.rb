require_relative 'card_deck'
require_relative 'hand'
require_relative 'rules'

module BlackJack
  class Dealer
    attr_reader :hand, :card_deck

    def initialize
      @hand = Hand.new
      @card_deck = CardDeck.new
    end

    def deal_card
      @card_deck = CardDeck.new if @card_deck.empty?
      @card_deck.upper_card
    end

    def reset_hand
      @hand = Hand.new
    end

    def give_win(situation, bet)
      bet * Rules::BET[situation]
    end
  end
end
