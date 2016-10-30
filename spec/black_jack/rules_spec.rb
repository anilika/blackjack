require 'black_jack/rules'

describe 'Rules' do
  describe 'constants' do
    describe 'MIN_BET' do
      it 'returns value of minimum bet' do
        expect(BlackJack::Rules::MIN_BET).to eq(10)
      end
    end
    describe 'MIN_CASH' do
      it 'returns minimum value for player cash' do
        expect(BlackJack::Rules::MIN_CASH).to eq(0)
      end
    end
    describe 'BLACK_JACK' do
      it 'returns number of points for BlackJack' do
        expect(BlackJack::Rules::BLACK_JACK).to eq(21)
      end
    end
  end
end
