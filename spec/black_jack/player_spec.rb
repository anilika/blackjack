require 'black_jack/player'
require 'black_jack/hand'
require 'black_jack/card'

describe 'Player' do
  before(:each) do
    @player = BlackJack::Player.new('John', 100)
  end

  before(:all) do
    @cards = [BlackJack::Card.new('Ds', [10]), BlackJack::Card.new('7s', [7]),
              BlackJack::Card.new('Jb', [10]), BlackJack::Card.new('Kd', [10]),
              BlackJack::Card.new('3s', [3])]
  end

  describe 'attributes' do
    it 'allows reading for :name' do
      expect(@player.name).to eq('John')
    end

    it 'allows reading for :cash' do
      expect(@player.cash).to eq(100)
    end

    it 'allows reading for :hands' do
      expect(@player.hands).to be_an(Array)
    end
  end

  describe '#make_bet_if_valid' do
    context 'when bet is valid' do
      it 'returns true' do
        expect(@player.make_bet_if_valid(20)).to be_truthy
      end
      it 'passes value that was passed as argument to hand' do
        @player.make_bet_if_valid(20)
        expect(@player.hands.last.bet).to eq(20)
      end
      it 'subtracts value that was passed as argument from variable :cash' do
        @player.make_bet_if_valid(20)
        expect(@player.cash).to eq(80)
      end
    end
    context 'when bet is not valid' do
      it 'return false' do
        expect(@player.make_bet_if_valid(1)).to be_falsey
      end
    end
  end

  describe '#take_win' do
    it 'adds value that was passed as argument to variable @cash' do
      @player.take_win(25)
      expect(@player.cash).to eq(125)
    end
  end

  describe '#bet_valid?' do
    context 'when bet valid' do
      it 'returns true' do
        expect(@player.bet_valid?(20)).to be_truthy
      end
    end
    context 'when bet invalid' do
      it 'returns false' do
        expect(@player.bet_valid?(2)).to be_falsey
      end
    end
  end

  describe '#reset_hands' do
    it 'clears array in variable :hands, creates new hand and placed it in :hands' do
      2.times { @player.hands.push(BlackJack::Hand.new) }
      expect(@player.hands.size).to eq(3)
      hands = @player.hands
      @player.reset_hands
      expect(@player.hands.size).to eq(1)
      expect(hands).not_to include(@player.hands.first)
    end
  end

  describe '#split' do
    before(:each) do
      @player.hands.push(BlackJack::Hand.new)
    end

    context 'when player is allowed to split' do
      it 'returns true and adds to variable :hands new hand with card of split' do
        @player.hands[0].add_card(@cards[0])
        @player.hands[0].add_card(@cards[1])
        @player.hands[1].add_card(@cards[2])
        @player.hands[1].add_card(@cards[3])
        print @player.hands.size
        expect(@player.split(2)).to be_truthy
        expect(@player.hands.size).to eq(3)
        expect(@player.hands[0].cards).to eq([@cards[0], @cards[1]])
        expect(@player.hands[1].cards).to eq([@cards[2]])
        print @player.hands[2].cards
        expect(@player.hands[2].cards).to eq([@cards[3]])
      end
    end

    context 'when player is not allowed to split' do
      it 'returns false' do
        @player.hands[0].add_card(@cards[0])
        @player.hands[0].add_card(@cards[1])
        @player.hands[1].add_card(@cards[2])
        @player.hands[1].add_card(@cards[4])
        expect(@player.split(2)).to be_falsey
      end
    end
  end

  describe '#can_double?' do
    context 'when player hand contains 10 or 11 points' do
      it 'returns true' do
        @player.hands[0].add_card(@cards[0])
        expect(@player.can_double?(1)).to be_truthy
      end
    end
    context 'when player just made split' do
      it 'returns true' do
        @player.hands[0].add_card(@cards[0])
        @player.hands[0].add_card(@cards[2])
        @player.split(1)
        expect(@player.can_double?(2)).to be_truthy
      end
    end
    context 'when else' do
      it 'returns false' do
        @player.hands[0].add_card(@cards[1])
        expect(@player.can_double?(1)).to be_falsey
      end
    end
  end

  describe '#double' do
    it 'to doubles bets' do
      @player.make_bet_if_valid(20)
      @player.double(1)
      expect(@player.hands.first.bet).to eq(40)
      expect(@player.cash).to eq(60)
    end
  end
end