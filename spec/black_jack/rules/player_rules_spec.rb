describe 'Player' do
  before(:all) do
    class TestPlayer
      attr_accessor :cards
      include Rules::Player
      def initialize
        @cards = []
      end
    end
    @player = TestPlayer.new
  end


  describe '#rate_valid?' do
    before(:all) do
      @player = BlackJack::Player.new('John', 100)
    end

    context 'when rate more then minimum rate and less or equal player cash' do
      it 'returns true' do
        expect(@player.rate_valid?(20)).to be_truthy
      end
    end

    context 'when rate less then minimum rate' do
      it 'returns false' do
        expect(@player.rate_valid?(2)).to be_falsey
      end
    end

    context 'when rate more then cash' do
      it 'returns false' do
        expect(@player.rate_valid?(200)).to be_falsey
      end
    end
  end
  describe '#split' do
    before(:each) do
      @player.cards = []
    end

    context 'when player is allowed to split' do
      it 'returns cards as array of arrays' do
        @player.cards << BlaskJack::Card.new('As', [11, 1])
        @player.cards << BlaskJack::Card.new('Ab', [11, 1])
        expect(@player.split).to eq([[cards[0]], [cards[1]]])
      end
    end

    caontext 'when player is not allowed to split' do
      it 'returns false' do
        @player.cards << BlaskJack::Card.new('8s', [8])
        @player.cards << BlaskJack::Card.new('Ab', [11, 1])
        expect(@player.split).to be_falsey
      end
    end

    context 'when pass with argument' do
      it 'splits that hand the number of which has been passed and returns all hands of player' do
        cards = [[BlaskJack::Card.new(['7s', [7]]), BlaskJack::Card.new(['10a', [10]])], [BlaskJack::Card.new('7a', [7]), BlaskJack::Card.new('7b', [7])]]
        @player.cards = cards
        expect(@player.split(1)).to eq([cards[0], [cards[1][0]], [cards[1][1]]])
      end
    end
  end
end