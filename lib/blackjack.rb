
module BlackJack
  class << self
    def start_game
      game = Game.new
      loop do
        game.round do |player|
          if player.black_jack?
            action = game.black_jack_choice
            game.send(action, player)
          end
          loop_for_each_hand do |hand|
            break if hand.win?
            action = PlayerInput.game_action
            break if action == :stand
            send(action, hand, player)
            break if hand.loose?
          end
        end
        lost_players.each { | player| game.over(player) }
        game.the_end if game.players.empty?
        action = PlayerInput.play_more
        break if action == :no
      end
    end
  end
end


