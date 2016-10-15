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
    before(:all) do
      module BlackJack
        MIN_RATE = 10
      end
    end

    context 'when rate less then minimum rate' do
      it 'returns false' do
        expect(@player.make_rate(2)).to be_falsey
      end
    end

    context 'when rate more then cash' do
      it 'returns false' do
        expect(@player.make_rate(200)).to be_falsey
      end
    end

    context 'when rate more then minimum rate and less or equal cash' do
      it 'returns rate' do
        expect(@player.make_rate(20)).to eq(20)
      end
    end

  end
end