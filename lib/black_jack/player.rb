require_relative 'hand'
require_relative 'rules'

module BlackJack
  class Player
    attr_reader :name, :cash, :bet, :hands

    def initialize(name, cash)
      @name = name
      @cash = cash
      @bet = 0
      @hands = [Hand.new]
    end

    def take_win(win)
      @cash += win
    end

    def make_bet(bet)
      hands.first.add_bet(bet)
      @cash -= bet
    end

    def reset_hands
      @hands = []
      @hands.push(Hand.new)
    end

    def split(hand)
      if hand.split?
        @hands << Hand.new([hand.give_last_card], true)
        @hands.last.add_bet(hand.bet)
        @cash -= hand.bet
        hand.splitted = true
      end
    end

    def can_double?(number_of_hand)
      @hands[number_of_hand -1].double?
    end

    def double(hand)
      @cash -= hand.bet
      hand.double
    end
  end
end
