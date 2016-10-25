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
  end
end
