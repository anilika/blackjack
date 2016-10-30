module BlackJack
  class Card
    attr_reader :name, :points, :suit

    def initialize(name, points)
      @name = name[0...-1]
      @suit = name[-1]
      @points = points
    end
  end
end
