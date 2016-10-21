require 'black_jack/rules'

describe 'Rules' do
  before(:all) do
    class TestDealer
      attr_reader :card_deсk
      include Rules::Dealer
    end

    class TestPlayer
      attr_accessor :cards
      include Rules::Player
      def initialize
        @cards = []
      end
    end
    class TestCardDeck
      include Rules::CardDeck
      attr_reader :card_deck
    end
    @dealer = TestDealer.new
    @player = TestPlayer.new
    @card_deck = TestCardDeck.new
  end

  describe 'Dealer' do
    describe '#rate_valid?' do
      before(:all) do
        @player = BlackJack::Player.new('John', 100)
      end

      context 'when rate more then minimum rate and less or equal player cash' do
        it 'returns rate' do
          expect(@dealer.make_rate(20, @player.cash)).to eq(20)
        end
      end

      context 'when rate less then minimum rate' do
        it 'returns false' do
          expect(@dealer.rate_valid?(2, @player.cash)).to be_falsey
        end
      end

      context 'when rate more then cash' do
        it 'returns false' do
          expect(@dealer.make_rate(200, @player.cash)).to be_falsey
        end
      end
    end

    describe '#calculate_cards' do
      context 'when the sum is not one' do
        it 'returns all possible sums of cards that are less or equal then 21 as array' do
          cards = []
          cards << BlaskJack::Card.new('As', [11, 1])
          cards << BlaskJack::Card.new('Ab', [11, 1])
          expect(@dealer.calculate_cards(cards)).to eq([2, 12])
        end
      end
      context 'when the sum is one' do
        it 'returns sum of cards that are less or equal then 21 as array' do
          cards = []
          cards << BlaskJack::Card.new('9s', [9])
          cards << BlaskJack::Card.new('10s', [10])
          expect(@dealer.calculate_cards(cards)).to eq([19])
        end
      end
    end

    describe '#hand_win?' do
      before(:all) do
        @cards = []
        @cards << BlaskJack::Card.new('As', [11, 1])
        @cards << BlaskJack::Card.new('Ab', [11, 1])
      end

      context 'when max of sums cards less then 21' do
        it 'returns :no' do
          expect(@dealer.hand_win?(@card)).to eq(:no)
        end
      end
      context 'when one of sums cards equal to 21' do
        it 'returns :yes' do
          @cards << BlackJack::Card.new('9s', [9])
          expect(@dealer.hand_win?(@cards)).to eq(:yes)
        end
      end
      context 'when min of sums cards more then 21' do
        it 'returns :bust' do
          @cards << BlackJack::Card.new('10s', [10])
          @cards << BlackJack::Card.new('10b', [10])
          expect(@dealer.hand_win?(@cards)).to eq(:bust)
        end
      end
    end
  end

  describe 'Player' do
    describe '#split' do
      before(:each) do
        @player.cards = []
      end

      context 'when player is allowed to split' do
        it 'returns cards as array of arrays' do
          @player.cards << BlaskJack::Card.new('As', [11, 1])
          @player.cards << BlaskJack::Card.new('Ab', [11, 1])
          expect(@player.split).to eq([[cards[0]], [cards[1]]])
        end
      end

      caontext 'when player is not allowed to split' do
        it 'returns false' do
          @player.cards << BlaskJack::Card.new('8s', [8])
          @player.cards << BlaskJack::Card.new('Ab', [11, 1])
          expect(@player.split).to be_falsey
        end
      end

      context 'when pass with argument' do
        it 'splits that hand the number of which has been passed and returns all hands of player' do
          cards = [[BlaskJack::Card.new(['7s', [7]]), BlaskJack::Card.new(['10a', [10]])], [BlaskJack::Card.new('7a', [7]), BlaskJack::Card.new('7b', [7])]]
          @player.cards = cards
          expect(@player.split(1)).to eq([cards[0], [cards[1][0]], [cards[1][1]]])
        end
      end
    end
  end

  describe 'CardDeck' do
    describe '#create_card_deck' do
      it 'creates variable @card_deсk' do
        expect(@card_deck.card_deсk).to be_nil
        @card_deck.create_card_deck
        expect(@card_deck.card_deck).not_to be_nil
      end
      it 'puts in variable @card_deck array of cards' do
        expect(@card_deck.card_deck).to be_an(Array)
      end
      it 'creates 42 cards' do
        expect(@card_deck.card_deсk.size).to eq(42)
      end
      it 'creates cards which are instance of class Card' do
        expect(@card_deck.card_deсk.sample).to be_instance_of(Card)
      end
    end
  end
end
