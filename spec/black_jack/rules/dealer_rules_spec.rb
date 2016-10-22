describe 'Dealer' do
  before(:all) do
    class TestDealer
      attr_reader :card_deсk
      include Rules::Dealer
    end
    @dealer = TestDealer.new
  end

  describe '#calculate_cards' do
    context 'when the sum is not one' do
      it 'returns all possible sums of cards that are less or equal then 21 as array' do
        cards = []
        cards << BlaskJack::Card.new('As', [11, 1])
        cards << BlaskJack::Card.new('Ab', [11, 1])
        expect(@dealer.calculate_cards(cards)).to eq([2, 12])
      end
    end
    context 'when the sum is one' do
      it 'returns sum of cards that are less or equal then 21 as array' do
        cards = []
        cards << BlaskJack::Card.new('9s', [9])
        cards << BlaskJack::Card.new('10s', [10])
        expect(@dealer.calculate_cards(cards)).to eq([19])
      end
    end
  end

  describe '#hand_win?' do
    before(:all) do
      @cards = []
      @cards << BlaskJack::Card.new('As', [11, 1])
      @cards << BlaskJack::Card.new('Ab', [11, 1])
    end

    context 'when max of sums cards less then 21' do
      it 'returns :no' do
        expect(@dealer.hand_win?(@card)).to eq(:no)
      end
    end
    context 'when one of sums cards equal to 21' do
      it 'returns :yes' do
        @cards << BlackJack::Card.new('9s', [9])
        expect(@dealer.hand_win?(@cards)).to eq(:yes)
      end
    end
    context 'when min of sums cards more then 21' do
      it 'returns :bust' do
        @cards << BlackJack::Card.new('10s', [10])
        @cards << BlackJack::Card.new('10b', [10])
        expect(@dealer.hand_win?(@cards)).to eq(:bust)
      end
    end
  end
end