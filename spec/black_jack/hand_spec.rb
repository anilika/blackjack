require 'black_jack/hand'

describe 'Hand' do
  before (:all) do
    @hand = BlackJack::Hand.new
  end

  describe 'attributes' do
    it 'allows reading and writing for :bet' do
      @hand.bet = 20
      expect(@hand.bet).to eq(20)
    end
  end
end