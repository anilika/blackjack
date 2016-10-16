require 'black_jack/dealer'

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
