require 'black_jack/card'

describe 'Card' do
  before(:each) do
    @card = BlackJack::Card.new('As', [11, 1])
  end

  describe 'attributes' do
    it 'allows reading for :name' do
      expect(@card.name).to eq('A')
    end

    it 'allows reading for :points' do
      expect(@card.points).to eq([11, 1])
    end

    it 'allows reading for :suit' do
      expect(@card.suit).to eq('s')
    end
  end
end