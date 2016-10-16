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

    it 'allows reading and writing for :rate' do
      expect(@player.rate).to eq(0)
      @player.rate(10)
      expect(@player.rate).to eq(10)
    end
  end

  describe '#make_rate' do
    it 'makes variable @rate equal value that was passed as argument' do
      @player.make_rate(20)
      expect(@player.rate).to eq(20)
    end
    it 'subtracts value that was passed as argument from variable @cash' do
      @player.make_rate(38).to
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