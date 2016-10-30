module BlackJack
  class Game
    def initialize(numbers_of_players)
      @dealer = Dealer.new
      @players = add_players(numbers_of_players)
    end

    def start_round
      @players.each do |player|
        player.make_bet(PlayerInput.bet(player.cash))
      end

    end

    def another_round?

    end

    private

    def add_players(number)
      (1..number).map do |numb|
        GameOutput.player_name(numb)
        name = PlayerInput.name
        GameOutput.player_cash(numb)
        cash = PlayerInput.cash
        Player.new(name, cash)
      end
    end
  end
end
