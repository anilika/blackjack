require_relative 'black_jack/card'
require_relative 'black_jack/card_deck'
require_relative 'black_jack/dealer'
require_relative 'black_jack/display'
require_relative 'black_jack/game_input'
require_relative 'black_jack/game_output'
require_relative 'black_jack/hand'
require_relative 'black_jack/player'
require_relative 'black_jack/rules'
require_relative 'black_jack/player_input'

module BlackJack
  class Game
    def initialize(numbers_of_players)
      @dealer = Dealer.new
      @players = add_players(numbers_of_players)
    end

    def start_round
      @players.each do |player|
        GameOutput.doing_bet(player.name)
        player.make_bet(PlayerInput.bet(player.cash))
      end
      @dealer.cards.push(@dealer.deal_card)
      @players.each do |player|
        2.times { player.hands.first.add_card(@dealer.deal_card) }
        # GameOutput.game_place(@dealer, player)
      end
    end

    def round
      @players.each do |player|
        GameOutput.player_turn(player.name)
        GameOutput.game_place(@dealer, player)
        if player.hands.first.black_jack?
          player.take_win(@dealer.give_win(:black_jack, player.hands.first.bet))
          GameOutput.player_win
        end
        player.hands.each do |hand|
          loop do
            GameOutput.player_actions
            action = PlayerInput.game_action
            break if action == :stand
            send(action, hand, player)
            break if hand.loose?
          end
        end
      end
    end

    def hit(hand, player)
      hand.add_card(@dealer.deal_card)
      GameOutput.game_place(@dealer, player)
      if hand.loose?
        GameOutput.bust
      end
    end

    def double(hand, player)
      if player.hands.size == 1
        if player.can_double?(1)
          puts 'yes'
          player.double(1)
          GameOutput.game_place(@dealer, player)
        else
          GameOutput.cant_double
        end
      else
        GameOutput.number_of_hands
        numb = PlayerInput.number_of_hands
        if player.can_double?(numb)
          player.double(numb)
          GameOutput.game_place(@dealer, player)
        else
          GameOutput.cant_double(num)
        end
      end
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


d = BlackJack::Game.new(2)
d.start_round
d.round


