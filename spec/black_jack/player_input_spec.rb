require 'black_jack/player_input'

describe 'PlayerInput' do
  describe '.name' do
    it 'returns passed name' do
      module BlackJack::Input
        NAMES = ['a', 'qasdewxzcvfr', '     ', 'john']
        def self.take_input
          NAMES.shift
        end
      end
      expect(BlackJack::PlayerInput.name).to eq('John')
    end
  end

  describe '.cash' do
    it 'returns passed cash' do
      module BlackJack::Input
        CASH = ['0', 'dfsf', 'd', 'SdsfSS', 'SS', '1000000', '1', '100']
        def self.take_input
          CASH.shift
        end
      end
      expect(BlackJack::PlayerInput.cash).to eq(100)
    end
  end

  describe '.bet' do
    it 'returns passed bet' do
      module BlackJack::Input
        BET = ['sswd', '1', '10000000000', ' ', '', '25']
        def self.take_input
          BET.shift
        end
      end
      expect(BlackJack::PlayerInput.bet(100)).to eq(25)
    end
  end

  describe '.game_action' do
    it 'returns passed game action' do
      module BlackJack::Input
        ACTIONS = ['sdsa', '123', 'yes', 'Doouuble', 'hit']
        def self.take_input
          ACTIONS.shift
        end
      end
      expect(BlackJack::PlayerInput.game_action).to eq(:hit)
    end
  end

  describe '.number_of_hands' do
    it 'returns passed number as a number' do
      module BlackJack::Input
        ACTIONS = ['sdsa', '#123', 'yes', 'Doouuble', 'hit', '1']
        def self.take_input
          ACTIONS.shift
        end
      end
      expect(BlackJack::PlayerInput.number_of_hands).to eq(1)
    end
  end

  describe '.yes_no' do
    it 'returns passed yes or no' do
      module BlackJack::Input
        ACTIONS = ['sdsa', '123', 'hit', 'yes']
        def self.take_input
          ACTIONS.shift
        end
      end
      expect(BlackJack::PlayerInput.yes_no).to eq(:yes)
    end
  end
end
