class BlackJack
  attr_accessor :player, :dealer, :stake
  MIN = 10
  def initialize(player_name, bank)
    @player = Player.new(player_name, bank)
    @dealer = Dealer.new
    @stake = 0.0
  end

  def check_stake
    true if @player.balance_sheet_audit > @stake && @stake >= MIN
  end

  def make_stake(new_stake)
    @stake = new_stake
    @player.bank -= @stake
  end

  def show_maps
    puts "======================================"
    puts "Your cards"
    @dealer.player_cards.each{|card| print "#{card[0]}#{card[1]} value #{card[2]}\n"}
    puts "--------------------------------------"
    puts "Dealer`s cards"
    @dealer.dealer_cards.each{|card| print "#{card[0]}#{card[1]} value #{card[2]}\n"}
    puts "======================================"
  end

  def show_balanse
    puts "Your balanse #{@player.bank}"
  end

  def add_winning
    @player.bank += @stake * 1.5
    nil_stake
  end

  def nil_stake
    @stake = 0
  end



  class Dealer
    attr_accessor :dealer_cards, :player_cards, :deck

    def initialize
      @dealer_cards = []
      @player_cards = []
    end

    def create_deck
      part_cards = %w{ 2 3 4 5 6 7 8 9 10 J D K T }
      suits = %w{b s d h}
      @deck = []
      suits.each do |suit|
        part_cards.zip([suit] * part_cards.length) do |card|
          case card[0]
          when "J", "D", "K" then card.push("10")
          when "T" then card.push("11")
          else
            card.push(card[0])
          end
        @deck << card
        end
      end
      @deck
    end

    def shuffle_deck
      @deck.shuffle!
    end

    def deal_card
      [@deck.slice!(-1)]
    end

    def deal_card_player
      @player_cards += deal_card
    end

    def deal_card_dealer
      @dealer_cards += deal_card
    end

    def check_t(cards_on_desk)
      @t = []
      cards_on_desk.each do |card|
        @t += card if card[0].include?"T"
      end
      @t
    end

    def sum_cards(cards_on_desk)
      sum_cards = 0
      cards_on_desk.each do |card|
        sum_cards += card.last.to_i
      end
      sum_cards
    end

    def sum_with_t(cards_on_desk)
      unless check_t(cards_on_desk) == []
        t = check_t(cards_on_desk)
        sum_cards = 0
        t.size.times do
            sum_cards -= 10
            break if @sum_cards == 21
        end
        sum_cards
      else
        0
      end
    end

    def check_21(cards_on_desk)
      sum_cards = sum_cards(cards_on_desk)
      if  sum_cards == 21
        true
      elsif sum_cards > 21
        true if sum_with_t(cards_on_desk) == 21
      else
        false
      end
    end

    def too_much(cards_on_desk)
      if sum_cards(cards_on_desk) <= 21
        false
      elsif
        if check_t(cards_on_desk) == []
          false
        else
          sum_cards = 0
          t = check_t(cards_on_desk)
          t.size.times do
            sum_cards -= 10
            break if sum_cards < 21
          end
          puts true if sum_cards > 21
        end
      end
    end

    def player_to_mach
      too_much(@player_cards)
    end

    def dealer_to_mach
      too_much(@dealer_cards)
    end

    def check_21_player_cards
      check_21(@player_cards)
    end

    def check_21_dealer_cards
      check_21(@dealer_cards)
    end

    def check_cards
      player_sums = dealer_sums = []
      player_sums << sum_cards(@player_cards)
      player_sums << sum_with_t(@player_cards)
      dealer_sums << sum_cards(@dealer_cards)
      dealer_sums << sum_with_t(@dealer_cards)
      if dealer_sums.max >= player_sums.max
        true
      else
        false
      end
    end

    def sum_num_dealer_cards
      dealer_sum = []
      dealer_sum << sum_cards(@dealer_cards)
      dealer_sum << sum_with_t(@dealer_cards)
      if dealer_sum.min.to_i == 0
        dealer_sum.max.to_i
      else
        dealer_sum.min.to_i
      end
    end

    def nil_cards
      @dealer_cards = []
      @player_cards = []
    end
  end

  class Player
    attr_accessor :bank

    def initialize(player_name, bank)
      @player_name = player_name
      @bank = bank.to_f
    end

    def balance_sheet_audit
      @bank if @bank > MIN
    end

  end
end
puts "Welcome to the game of Black Jack"
puts "Enter the name of the player"
player_name = gets.chomp
puts "Put the money into the account, the minimum rate of 10"
bank = gets.chomp
my_game = BlackJack.new(player_name, bank.to_i)
loop do
  unless my_game.player.balance_sheet_audit
    puts "not enough money, game over"
    break
  end
  my_game.dealer.create_deck
  my_game.dealer.shuffle_deck
  puts "Your balanse #{my_game.player.bank}"
  8.times do
    loop do
      puts "Type 'q' to exit"
      puts "Your balanse #{my_game.player.bank}"
      puts "Yor bet"
      bet = gets.chomp
      return if bet == 'q'
      my_game.make_stake(bet.to_i)
      puts "Your balanse #{my_game.player.bank}"
      break if my_game.check_stake
      puts "Rate exceeds the limit on the account"
      puts "Or less than the minimum rate"
      puts "Enter the new rates"
    end
    my_game.dealer.deal_card_player
    my_game.dealer.deal_card_player
    my_game.dealer.deal_card_dealer
    my_game.show_maps
    if my_game.dealer.check_21_player_cards
        my_game.add_winning
        puts "You won, it`s a BlackJack!"
        my_game.nil_stake
        my_game.dealer.nil_cards
        redo
    end
    puts "Dial 'hit me' or 'end turn'"
    act = gets.chomp
    until act == "end turn"
      case act
      when "hit me"
        my_game.dealer.deal_card_player
        my_game.show_maps
        if my_game.dealer.player_to_mach
          puts "Too much"
          puts "Your loose"
          my_game.nil_stake
          my_game.dealer.nil_cards
          break
        elsif my_game.dealer.check_21_player_cards
          puts "21"
        else
          puts "Dial 'hit me' or 'end turn'"
          act = gets.chomp
        end
      when "end turn"
        act = "end turn"
      else
        puts "Wrong argument!"
      end
    end
    while my_game.dealer.sum_num_dealer_cards < 17
      my_game.dealer.deal_card_dealer
    end
    my_game.show_maps
    if my_game.dealer.dealer_to_mach
      puts "Dealer loose. You win!"
      my_game.add_winning
      my_game.nil_stake
      my_game.dealer.nil_cards
      break
    end
    if my_game.dealer.check_cards
      puts "Your loose"
      my_game.nil_stake
      my_game.dealer.nil_cards
      break
    else
      puts "Dealer loose. You win!"
      my_game.add_winning
      my_game.nil_stake
      my_game.dealer.nil_cards
      break
    end
  end
end
