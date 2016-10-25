require 'black_jack/hand'
require 'black_jack/card'

describe 'Hand' do
  before (:all) do
    @hand = BlackJack::Hand.new
  end

  describe 'attributes' do
    it 'allows reading and writing for :bet' do
      @hand.bet = 20
      expect(@hand.bet).to eq(20)
    end
    it 'allows reading for :cards' do
      expect(@hand.cards).to eq([])
    end
  end

  describe '#add_cards' do
    it 'pushes each card that was passed as argument in variable @cards' do
      first_card = BlaskJack::Card.new('9s', [9])
      @hand.add_cards(first_card)
      expect(@hand.cards).to eq(first_card)
      second_card = (BlaskJack::Card.new('As', [11, 1]))
      @hand.add_card(second_card)
      expect(@hand.cards).to eq([first_card, second_card])
    end
  end

  describe '#cards_name' do
    it 'returns name of each card in hand as array of string' do
      expect(@hand.cards_names).to eq(['9s', 'As'])
    end
  end

  describe '#cards_sums' do
    it 'returns all sums of cards points which less or equal 21' do
      expect(@hand.cards_sums).to eq([20, 10])
    end
  end

  describe '#max_sum' do
    it 'returns maximum sum of cards' do
      expect(@hand.max_sum).to eq(20)
    end
  end

  describe '#black_jack?' do
    context 'when no one of cards_sums equal 21' do
      it 'returns false' do
        expect(@hand.black_jack?).to be_falsey
      end
    end
    context 'when one of cards_sums equal 21' do
      it 'returns true' do
        @hand.add_card((BlaskJack::Card.new('Ab', [11, 1])))
        expect(@hand.black_jack?).to be truthy
      end
    end
  end
end