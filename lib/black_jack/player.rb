module BlackJack
  class Player
    attr_reader :name, :cash, :rate

    def initialize(name, cash)
      @name = name
      @cash = cash
      @rate = 0
    end
  end
end
