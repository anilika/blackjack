class BlackJack
  attr_accessor :player, :dealer, :stake
  MIN = 10.0
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
      return true if numb_con > 1
      show_balanse
      return false if nil_balans
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
    end
  end

  def dealer_turn
    until (@dealer.sum_dealer_cards).min >= 17
      @dealer.deal_card_dealer
    end
    show_maps
    @dealer.dealer_to_mach ? false : true
  end


  def player_turn
    loop do
      puts "Dial 'hit me' or 'end turn'"
      act = gets.chomp
      case act
      when "end turn"
        break
      when "hit me"
        hit_me
        if @dealer.check_21_player_cards && (@dealer.dealer_cards).size == 1
          add_winning
          return true
        elsif @dealer.check_21_player_cards
          return false
        elsif @dealer.player_to_mach
          loos
          return true
        else
          redo
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

  def nil_balans
    true if @player.bank < MIN
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

    def sum_cards(cards)
      first_sum_cards = 0
      i_a = 0
      sum_cards = []
      cards.each do |card|
        i_a += 1 if card.include?"A"
        first_sum_cards += card.last.to_i
      end
      sum_cards << first_sum_cards
      i_a.times do
        next_sum = first_sum_cards -= 10
        sum_cards << next_sum if next_sum > 0
      end
      sum_cards
    end

    def sum_dealer_cards
      sum_cards(@dealer_cards)
    end

    def sum_player_cards
      sum_cards(@player_cards)
    end

    def too_much(cards_on_deck)
      mach_numb = sum_cards(cards_on_deck).select{|numb| numb > 21}
      mach_numb.size == sum_cards(cards_on_deck).size ? true : false
    end

    def check_21(sum_cards)
      sum_cards.include?(21) ? true : false
    end

    def player_to_mach
      too_much(@player_cards)
    end

    def dealer_to_mach
      too_much(@dealer_cards)
    end

    def check_21_player_cards
      check_21(sum_player_cards)
    end

    def check_21_dealer_cards
      check_21(sum_dealer_cards)
    end

    def check_cards
      dealer_valid_sum = sum_dealer_cards.select{|numb| numb <= 21}
      player_valid_sum = sum_player_cards.select{|numb| numb <= 21}
      if dealer_valid_sum.max >= player_valid_sum.max
        true
      else
        false
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


