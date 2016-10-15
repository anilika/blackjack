require 'black_jack/dealer'

describe 'Dealer' do
  before(:each) do
    @dealer = BlackJack::Dealer.new
  end

  describe '#deal_card' do
    it 'returns card' do
      expect(@dealer.deal_card).to be_instance_of(BlackJack::Card)
    end
  end
end
