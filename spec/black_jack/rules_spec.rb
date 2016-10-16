require 'black_jack/rules'

describe 'Rules' do
  before(:all) do
    class TestRules
      attr_reader :card_deсk
      include Rules
    end
    @rules = TestRules.new
  end

  describe '#rate_valid?' do
    context 'when rate less then minimum rate' do
      it 'returns false' do
        expect(@rules.rate_valid?(2)).to be_falsey
      end
    end

    context 'when rate more then minimum rate' do
      it 'returns rate' do
        expect(@rules.make_rate(20)).to eq(20)
      end
    end
  end

  describe '#calculate_cards' do
    context 'when the sum is not one' do
      it 'returns all possible sums of cards that are less or equal then 21 as array' do
        cards = []
        cards << BlaskJack::Card.new('As', [11, 1])
        cards << BlaskJack::Card.new('Ab', [11, 1])
        expect(@rules.calculate_cards(cards)).to eq([2, 12])
      end
    end
    context 'when the sum is one' do
      it 'returns sum of cards that are less or equal then 21 as array' do
        cards = []
        cards << BlaskJack::Card.new('9s', [9])
        cards << BlaskJack::Card.new('10s', [10])
        expect(@rules.calculate_cards(cards)).to eq([19])
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
        expect(@rules.hand_win?(@card)).to eq(:no)
      end
    end
    context 'when one of sums cards equal to 21' do
      it 'returns :yes' do
        @cards << BlackJack::Card.new('9s', [9])
        expect(@rules.hand_win?(@cards)).to eq(:yes)
      end
    end
    context 'when min of sums cards more then 21' do
      it 'returns :bust' do
        @cards << BlackJack::Card.new('10s', [10])
        @cards << BlackJack::Card.new('10b', [10])
        expect(@rules.hand_win?(@cards)).to eq(:bust)
      end
    end
  end

  describe '#create_card_deck' do
    before(:all) do
      @rules.create_card_deck
    end

    it 'creates variable @card_deсk' do
      expect(@rules.card_deсk.empty?).to be_falsey
    end
    it 'puts in variable @card_deck array of cards' do
      expect(@rules.card_deck).to be_an(Array)
    end
    it 'creates 42 cards' do
      expect(@rules.card_deсk.size).to eq(42)
    end
    it 'creates cards which are instance of class Card' do
      expect(@rules.card_deсk.sample).to be_instance_of(Card)
    end
  end
end