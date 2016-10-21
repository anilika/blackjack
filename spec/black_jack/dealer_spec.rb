require 'black_jack/dealer'
require 'black_jack/card'

describe 'Dealer' do
  before(:each) do
    @dealer = BlackJack::Dealer.new
  end

  describe 'attributes' do
    before (:all) do
      @card = BlackJack::Card.new('As', [11, 1])
    end

    it 'allows reading for :cards' do
      @dealer.cards.push(@card)
      expect(@dealer.cards).to eq([@card])
    end
    it 'not allows writing for :cards' do
      expect { @dealer.cards = @card }.to raise_error(NoMethodError)
    end
  end

  describe '#create_card_deck' do
    before(:all) do
      @dealer.create_card_deck
    end

    it 'creates variable @card_deсk' do
      expect(@dealer.card_deсk.empty?).to be_falsey
    end
    it 'puts in variable @card_deck array of cards' do
      expect(@dealer.card_deck).to be_an(Array)
    end
    it 'creates 42 cards' do
      expect(@dealer.card_deсk.size).to eq(42)
    end
    it 'creates cards which are instance of class Card' do
      expect(@dealer.card_deсk.sample).to be_instance_of(Card)
    end
  end

  describe '#deal_card' do
    context 'when pass an argument' do
      it 'returns a number of cards which was passed as array of object' do
        expect(@dealer.deal_card(2).size).to eq(2)
      end
    end
    context 'when pass no argument' do
      it 'returns one card as object' do
        expect(@dealer.deal_card).to be_instance_of(BlackJack::Card)
      end
    end
  end
end
