require 'black_jack/player'

describe 'Player' do
  before(:all) do
    @player = BlackJack::Player.new('John', 100)
  end
  describe 'attributes' do
    it 'allows reading for :name' do
      expect(@player.name).to eq('John')
    end

    it 'allows reading for :cash' do
      expect(@player.cash).to eq(100)
    end

    it 'allows reading for :hands' do
      expect(@player.hands).to be_an(Array)
    end
  end

  describe '#make_bet_if_valid' do
    context 'when bet is valid' do
      it 'returns true' do
        expect(@player.make_bet_if_valid(20)).to be_truthy
      end
      it 'passes value that was passed as argument to hand' do
        expect(@player.hands.last.bet).to eq(20)
      end
      it 'subtracts value that was passed as argument from variable :cash' do
        expect(@player.cash).to eq(80)
      end
    end
    context 'when bet is not valid' do
      it 'return false' do
        expect(@player.make_bet_if_valid(1)).to be_falsey
      end
    end
  end

  describe '#take_win' do
    it 'adds value that was passed as argument to variable @cash' do
      @player.take_win(25)
      expect(@player.cash).to eq(105)
    end
  end

  describe '#bet_valid?' do
    context 'when bet valid' do
      it 'returns true' do
        expect(@player.bet_valid?(20)).to be_truthy
      end
    end
    context 'when bet invalid' do
      it 'returns false' do
        expect(@player.bet_valid?(2)).to be_falsey
      end
    end
  end
end