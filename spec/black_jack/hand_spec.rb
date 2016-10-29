require 'black_jack/hand'
require 'black_jack/card'

describe 'Hand' do
  before(:all) do
    @card = BlackJack::Card.new('As', [11, 1])
    @cards = [BlackJack::Card.new('9s', [9]), BlackJack::Card.new('Ad', [11, 1]),
              BlackJack::Card.new('Jd', [10]), BlackJack::Card.new('Db', [10]),
              BlackJack::Card.new('3b', [3]), BlackJack::Card.new('7b', [7])]
  end
  before (:each) do
    @hand = BlackJack::Hand.new([@card])
  end

  describe 'attributes' do
    it 'allows reading for :bet' do
      @hand.add_bet(20)
      expect(@hand.bet).to eq(20)
    end
    describe ':cards' do
      it 'allows reading for :cards' do
        expect(@hand.cards).to contain_exactly(@card)
      end
      context 'when passed with no argument' do
        it 'sets cards equal []' do
          hand = BlackJack::Hand.new
          expect(hand.cards).to eq([])
        end
      end
    end
  end

  describe '#add_cards' do
    it 'pushes each card that was passed as argument in variable :cards' do
      @hand.add_card(@cards[0])
      expect(@hand.cards).to contain_exactly(@card, @cards[0])
      @hand.add_card(@cards[1])
      expect(@hand.cards).to contain_exactly(@card, @cards[0], @cards[1])
    end
  end

  describe '#add_bet' do
    it 'pushes value that was passed as argument in variable :bet' do
      @hand.add_bet(20)
      expect(@hand.bet).to eq(20)
      @hand.add_bet(15)
      expect(@hand.bet).to eq(15)
    end
  end

  describe '#cards_name' do
    it 'returns name of each card in hand as array of string' do
      @hand.add_card(@cards[0])
      expect(@hand.cards_names).to eq(['As', '9s'])
    end
  end

  describe '#cards_sums' do
    it 'returns all sums of cards points which less or equal 21' do
      @hand.add_card(@cards[0])
      expect(@hand.cards_sums).to eq([20, 10])
    end
  end

  describe '#max_sum' do
    it 'returns maximum sum of cards' do
      @hand.add_card(@cards[0])
      expect(@hand.max_sum).to eq(20)
    end
  end

  describe '#black_jack?' do
    context 'when no one of cards_sums equal 21' do
      it 'returns false' do
        expect(@hand.black_jack?).to be_falsey
      end
    end
    context 'when one of cards_sums equal 21' do
      it 'returns true' do
        @hand.add_card(@cards[2])
        expect(@hand.black_jack?).to be_truthy
      end
    end
  end

  describe '#split?' do
    before(:each) do
      @hand.cards.clear
    end
    context 'when :cards can be split' do
      it 'returns true' do
        @hand.add_card(@cards[2])
        @hand.add_card(@cards[3])
        expect(@hand.split?).to be_truthy
      end
    end
    context 'when :cards can not be split' do
      it 'returns false' do
        @hand.add_card(@cards[2])
        @hand.add_card(@cards[1])
        expect(@hand.split?).to be_falsey
      end
    end
    context 'when :cards include more then two cards' do
      it 'return false' do
        @hand.add_card(@cards[1])
        @hand.add_card(@cards[4])
        @hand.add_card(@cards[5])
        expect(@hand.split?).to be_falsey
      end
    end
  end

  describe '#give_last_card' do
    it 'deletes and returns last card from :cards' do
      @hand.add_card(@cards[1])
      expect(@hand.give_last_card).to eq(@cards[1])
      expect(@hand.cards).to contain_exactly(@card)
    end
  end
end