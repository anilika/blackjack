require_relative 'input'

module BlackJack
  class GameInput
    def self.players
      players = false
      until players
        begin
          players = Integer(Input.take_input)
          players = false if players > 3
        rescue
          players = false
        end
      end
      players
    end
  end
end
