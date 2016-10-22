require 'black_jack/rules'

describe 'Rules' do
  describe 'constants' do
    describe 'MIN_RATE' do
      it 'returns value of minimum rate' do
        expect(RULES::MIN_RATE).to be_an(Numeric)
      end
    end
  end
end
