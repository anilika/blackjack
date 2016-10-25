require 'black_jack/rules'

describe 'Rules' do
  describe 'constants' do
    describe 'MIN_RATE' do
      it 'returns value of minimum rate' do
        expect(BlackJack::Rules::MIN_RATE).to eq(20)
      end
    end
    describe 'MIN_CASH' do
      it 'returns minimum value for player cash' do
        expect(BlackJack::Rules::MIN_CASH).to eq(0)
      end
    end
  end
end
