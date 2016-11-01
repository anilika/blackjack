require_relative 'rules'
require_relative 'input'

module BlackJack
  class PlayerInput
    def self.name
      range = (Rules::PLAYER_NAME[:more]..Rules::PLAYER_NAME[:less])
      loop do
        name = Input.take_input
        next if name.split.size.zero?
        if range.include?(name.size)
          return name.capitalize
        end
      end
    end

    def self.cash
      range = (Rules::PLAYER_CASH[:more]..Rules::PLAYER_CASH[:less])
      loop do
        begin
          cash = Integer(Input.take_input)
        rescue
          next
        end
        return cash if range.include?(cash)
      end
    end

    def self.bet(cash)
      range = (Rules::MIN_BET..cash)
      loop do
        begin
          bet = Integer(Input.take_input)
        rescue
          next
        end
        return bet if range.include?(bet)
      end
    end

    def self.game_action
      loop do
        action = Input.take_input.downcase.to_sym
        if Rules::PLAYER_ACTION.include?(action)
          return action
        end
      end
    end

    def self.yes_no
      loop do
        action = Input.take_input.downcase.to_sym
        if Rules::PLAYER_YES_NO.include?(action)
          return action
        end
      end
    end

    def self.number_of_hands
        loop do
          begin
            number = Integer(Input.take_input)
            return number
          rescue
            next
          end
        end
    end
  end
end