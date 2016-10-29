require_relative 'hand'
require_relative 'rules/rules'

module BlackJack
  class Player
    attr_reader :name, :cash, :bet, :hands

    def initialize(name, cash)
      @name = name
      @cash = cash
      @bet = 0
      @hands = [Hand.new]
    end

    def make_rate(rate)
      @cash -= rate
      @bet = bet
    end

    def take_win(win)
      @cash += win
    end

    def make_bet_if_valid(bet)
      if bet_valid?(bet)
        hands.first.add_bet(bet)
        @cash -= bet
        true
      else
        false
      end
    end

    def bet_valid?(bet)
      begin
        bet = Integer(bet)
      rescue
        return false
      end
      bet <= cash && bet >= Rules::MIN_BET
    end

    def reset_hands
      @hands = []
      @hands.push(Hand.new)
    end

    def split(number_of_hand)
      hand = @hands[number_of_hand - 1]
      if hand.split?
        @hands << Hand.new([hand.give_last_card], true)
        hand.splitted = true
      end
    end

    def can_double?(number_of_hand)
      @hands[number_of_hand -1].double?
    end

    def double(number_of_hand)
      hand = @hands[number_of_hand -1]
      @cash -= hand.bet
      hand.double
    end
  end
end
