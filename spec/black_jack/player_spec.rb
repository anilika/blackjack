require 'black_jack/player'

describe 'Player' do
  before(:each) do
    @player = BlackJack::Player.new('John', 100)
  end
  describe 'attributes' do
    it 'allows reading for :name' do
      expect(@player.name).to eq('John')
    end

    it 'allows reading for :cash' do
      expect(@player.cash).to eq(100)
    end

    it 'allows reading for :bet' do
      expect(@player.bet).to eq(0)
    end

    it 'allows reading for :hands' do
      expect(@player.hands).to eq([])
    end
  end

  describe '#make_bet' do
    it 'makes variable @bet equal value that was passed as argument' do
      @player.make_bet(20)
      expect(@player.bet).to eq(20)
    end
    it 'subtracts value that was passed as argument from variable @cash' do
      @player.make_bet(38)
      expect(@player.cash).to eq(62)
    end
  end

  describe '#take_win' do
    it 'adds value that was passed as argument to variable @cash' do
      @player.take_win(25)
      expect(@player.cash).to eq(125)
    end
  end
end