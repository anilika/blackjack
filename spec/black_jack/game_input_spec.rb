require 'black_jack/game_input'

describe 'GameInput' do
  describe '.players' do
    it 'takes numbers of players and returns its' do
      module BlackJack::Input
        def self.take_input
          '3'
        end
      end
      expect(BlackJack::GameInput.players).to eq(3)
    end
    context 'when passed wrong value' do
      it 'requests until right value' do
        module BlackJack::Input
          DATA = ['a', 'fff', '5', '100', '3', '1']
          def self.take_input
            DATA.shift
          end
        end
        expect(BlackJack::GameInput.players).to eq(3)
      end
    end
  end
end