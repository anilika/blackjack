require 'black_jack/card_deck'

describe 'CardDeck' do
  before(:each) do
    class CardDeck
      attr_reader :cards
    end
    @card_deck = CardDeck.new
  end

  describe '#upper_card' do
    it 'deletes first card from array of cards and returns it' do
      first_card = @card_deck.cards.first
      expect(@card_deck.upper_card).to eq(first_card)
    end
  end

  describe '#lower_card' do
    it 'deletes last card from array of cards and returns it' do
      last_card = @card_deck.cards.last
      expect(@card_deck.lower_card).to eq(last_card)
    end
  end

  describe '#shuffle' do
    it 'shuffles elements of cards array' do
      first_ten_cards = @card_deck.cards[0..9]
      @card_deck.shuffle
      expect(@card_deck.cards[0..9]).not_to eq(first_ten_cards)
    end
  end

  describe '#number_of' do
    it 'returns the number of elements in array of cards' do
      expect(@card_deck.number_of).to eq(42)
    end
  end

  describe '#empty?' do
    context 'when array of cards is not empty' do
      it 'returns false' do
        expect(@card_deck.empty?).to be_falsey
      end
    end
    context 'when array of cards is empty' do
      it 'returns true' do
        @card_deck.cards.clear
        expect(@card_deck.empty?).to be_truthy
      end
    end
  end
end