module BlackJack
  class Round
    def initialize(players)
      @dealer = Dealer.new
      @players = players
    end

    def make_bets
      @players.each do |player|
        Display.make_bet(player.name)
        bet = nil
        until bet
          input = IOter.player_bet
          player.bet_valid?(input) ?
        loop do
          bet = IOter.player_bet
          @dealer.player_bet_valid?(bet)

        player.make_bet(IOter.player_bet) }
      end
    end

    end



      @players.each { |player| player.make_bet(IOter.get_bet) }
      @players.each { |player| player.take_cards(@dealer.deal_card(2)) }
      @dealer.deal_card_to_self
    IOter.show_dealer_cards(@dealer.hand.cards)
    @players.each do |player|
      IOter.show_player(player.name)
      player.hands.each { |hand| IOter.show_player}
    end
      @players. each do |player|
        player.take_win if player.hands.any?(&:win?)
        IOter.
    end
  end
  class << self
   def start_game
     IOter.greetings
     number_of_players = IOter.get_number_of_players
     players = []
     number_of_players.times do
       players.push(Player.new(IOter.get_name, IOter.get_cash))
     end
     game = Game.new(players)
   end
  end
end