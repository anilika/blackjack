class BlackJack
  attr_accessor :player, :dealer, :stake
  MIN = 10
  def initialize
    puts "Welcome to the game of Black Jack"
    @player = Player.new(check_name, check_bank)
    @dealer = Dealer.new
    @stake = 0.0
  end

  def new_game
    loop do
      @dealer.create_deck
      @dealer.shuffle_deck
      unless new_kon
        puts "game over"
        break
      end
    end
  end

  def new_kon
  numb_con = 0
    loop do
      break if numb_con > 8
      show_balanse
      puts "Type 'q' to exit"
      return false if  check_stake == :out
      make_stake
      first_deal_cards
      numb_con += 1
      if @dealer.check_21_player_cards
        puts "It`s a BlackJack!"
        add_winning
        redo
      end
      redo if player_turn
      unless dealer_turn
        add_winning
        redo
      end
      if @dealer.check_cards
        loos
      else
        add_winning
      end
      return false unless check_balans
    end
  end

  def dealer_turn
    sum, sum_with_a = @dealer.dealer_sum_cards
    puts sum
    puts sum_with_a
    until sum >= 17 || sum_with_a >= 17
      @dealer.deal_card_dealer
      sum, sum_with_a = @dealer.dealer_sum_cards
      puts sum
      puts sum_with_a
    end
    false if @dealer.dealer_to_mach
  end


  def player_turn
    loop do
      puts "Dial 'hit me' or 'end turn'"
      act = gets.chomp
      case act
      when "end turn"
        break
      when "hit me"
        if hit_me
          add_winning
          return true
        elsif hit_me == 0
          redo
        else
          loos
          return true
        end
      else
        puts "Wrong argument!"
        redo
      end
    end
  end

  def hit_me
    @dealer.deal_card_player
    show_maps
    if @dealer.player_to_mach
      false
    elsif @dealer.check_21_player_cards
      true
    else
      0
    end
  end

  def first_deal_cards
    @dealer.deal_card_player
    @dealer.deal_card_player
    @dealer.deal_card_dealer
    show_maps
  end

  def check_name
    player_name = ""
    loop do
      puts "Enter the name of the player"
      player_name = gets.chomp
      break unless player_name.size == 0
      puts "Invalid name"
    end
    player_name
  end

  def check_bank
    bank = 0
    loop do
      puts "Put the money into the account, the minimum rate of 10"
      bank = gets.chomp.to_f
      break if bank >= MIN
      puts "Not enough money"
    end
    bank
  end

  def check_balans
    false if @player.bank < MIN
  end

  def check_stake
    loop do
      puts "Yor bet"
      bet = gets.chomp
      return :out if bet == 'q'
      if bet.to_f > @player.bank
        puts "Your stak more your bank"
        puts "Enter the new rates"
      elsif bet.to_f < MIN
        puts "Your stake less min stake"
        puts "Enter the new rates"
      else
        @stake = bet.to_f
        break
      end
    end
  end

  def make_stake
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
    puts "You win!"
    @player.bank += @stake * 1.5
    nil_stake
    @dealer.nil_cards
  end

  def nil_stake
    @stake = 0
  end

  def loos
    puts "Your loose"
    nil_stake
    @dealer.nil_cards
  end


  class Dealer
    attr_accessor :dealer_cards, :player_cards, :deck

    def initialize
      @dealer_cards = []
      @player_cards = []
    end

    def create_deck
      part_cards = %w{ 2 3 4 5 6 7 8 9 10 J D K A }
      suits = %w{b s d h}
      @deck = []
      suits.each do |suit|
        part_cards.zip([suit] * part_cards.length) do |card|
          case card[0]
          when "J", "D", "K" then card.push("10")
          when "A" then card.push("11")
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

    def check_a(cards_on_desk)
      a = cards_on_desk.select{|card| card.include?"A"}
    end

    def sum_cards(cards_on_desk)
      sum_cards = 0
      cards_numb = cards_on_desk.transpose.last
      cards_numb.each do |card|
        sum_cards += card.to_i
      end
      sum_cards
    end

    def sum_with_a(cards_on_desk)
      unless check_a(cards_on_desk) == []
        a = check_a(cards_on_desk)
        sum_cards = 0
        a.size.times do
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
        true if sum_with_a(cards_on_desk) == 21
      else
        false
      end
    end

    def too_much(cards_on_desk)
      if sum_cards(cards_on_desk) <= 21
        false
      elsif
        if check_a(cards_on_desk) == []
          false
        else
          sum_cards = 0
          a = check_a(cards_on_desk)
          a.size.times do
            sum_cards -= 10
            break if sum_cards <= 21
          end
          puts sum_cards > 21 ? true : false
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

    def dealer_sum_cards
      return sum_cards(@dealer_cards), sum_with_a(@dealer_cards)
    end

    def check_cards
      player_sums = dealer_sums = []
      player_sums << sum_cards(@player_cards)
      player_sums << sum_with_a(@player_cards)
      dealer_sums << sum_cards(@dealer_cards)
      dealer_sums << sum_with_a(@dealer_cards)
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
  end
end
my_game = BlackJack.new
my_game.new_game


