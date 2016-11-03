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
    it 'allows reading for :hand' do
      expect(@dealer.hand).to be_instance_of(BlackJack::Hand)
    end
  end

  describe '#deal_card' do
    it 'returns one card as object' do
      expect(@dealer.deal_card).to be_instance_of(BlackJack::Card)
    end
  end

  describe '#give_win' do
    it 'takes a bet and situation and returns bet multiplied by coefficient of situation' do
      bet = 20
      expect(@dealer.give_win(:black_jack, bet)).to eq(30)
      expect(@dealer.give_win(:push, bet)).to eq(20)
    end
  end
end
