require 'black_jack/dealer'

describe 'Dealer' do
  before(:each) do
    @dealer = BlackJack::Dealer.new
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
