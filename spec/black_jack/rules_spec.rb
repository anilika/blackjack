require 'black_jack/rules'

describe 'Rules' do
  describe '#rate_valid?' do
    context 'when rate less then minimum rate' do
      it 'returns false' do
        expect(BlackJack::Rules.rate_valid?(2)).to be_falsey
      end
    end

    context 'when rate more then minimum rate' do
      it 'returns rate' do
        expect(@player.make_rate(20)).to eq(20)
      end
    end
  end

  describe '#hand_win?' do

  end
end