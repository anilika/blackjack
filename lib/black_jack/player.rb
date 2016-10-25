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
      @rate = rate
    end

    def take_win(win)
      @cash += win
    end

  end
end
