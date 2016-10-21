module BlackJack
  class Player
    attr_reader :name, :cash, :rate

    def initialize(name, cash)
      @name = name
      @cash = cash
      @rate = 0
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
