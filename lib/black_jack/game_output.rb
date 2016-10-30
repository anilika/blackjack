require_relative 'card'
require_relative 'hand'
module BlackJack
  class GameOutput
    SUITS = { s: "\u{2664}", c: "\u{2667}",
              d: "\u{2662}", h: "\u{2661}" }

    CARD =['+-----+', '|name   |', '|  suit  |', '|   name|',
           '+-----+', '+-----+', '|points|', '+-----+']
    TITLE = <<DDD
```````````````````````````o3o````````````````````````````````````````````````````````
``v¶¶_``q¶¶_``o¶v``````````3¶3````````````````````````````````````````````````````````
```¶¶q``¶¶¶q``¶$```o¶¶¶v```3¶3````q¶¶$3```o¶¶¶3_```o3v–¶¶8_`3¶¶v``````````````````````
```v¶¶`o¶q¶¶`o¶–`o¶¶_`o¶$``3¶3``$¶¶v``_`o¶¶v`_¶¶¶``3¶¶3_3¶¶¶_o¶¶_`````````````````````
````¶¶8¶3`$¶$¶8``3¶¶¶¶¶¶¶``3¶3`_¶¶o`````3¶3```v¶¶–`3¶3``v¶¶``_¶¶_`````````````````````
````v¶¶¶–`v¶¶¶–``o¶¶v``````3¶3``¶¶¶–````o¶¶–``8¶¶``3¶3``v¶¶``_¶¶_`````````````````````
`````$¶3```¶¶3`````q¶¶¶¶8``q¶3```–$¶¶¶¶```3¶¶¶¶–```q¶3``v¶$``_¶¶_`````````````````````
``````````````````````````````````````````````````````````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````
````vo_```````````````````````````````````````````````````````````````````````````````
``_$¶¶$3```o¶¶¶3_`````````````````````````````````````````````````````````````````````
```–¶¶–``o¶¶v`_¶¶¶````````````````````````````````````````````````````````````````````
```_¶¶_``3¶3```v¶¶–```````````````````````````````````````````````````````````````````
```_¶¶–``o¶¶–``8¶¶````````````````````````````````````````````````````````````````````
````v¶¶¶–``3¶¶¶¶–`````````````````````````````````````````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````
`````````````_33````````````````````_33```````````````````````````````````_33`````````
```_¶¶¶¶¶¶¶``_¶¶````````````````````_¶¶````````````_¶¶–```````````````````_¶¶`````````
```_¶¶``v¶¶_`_¶¶``_q$¶¶3_````–3¶¶$o`_¶¶``_33_``````_¶¶_``o8¶¶8v````–3¶¶$o`_¶¶``_33_```
```_¶¶¶¶¶8```_¶¶``__``–¶¶_`_¶¶¶_``_`_¶¶`q¶3````````_¶¶_``–```¶¶o`_¶¶¶_``_`_¶¶`q¶3`````
```_¶¶``o¶¶v`_¶¶``v¶¶¶¶¶¶_`o¶¶–`````_¶¶¶¶$`````````_¶¶_`_¶¶¶¶¶¶o`o¶¶–`````_¶¶¶¶$``````
```_¶¶``v¶¶3`_¶¶`_¶¶–`v¶¶_`_¶¶8`````_¶¶`q¶¶o```````_¶¶_`3¶q``$¶o`_¶¶8`````_¶¶`q¶¶o````
```_¶¶¶¶¶8–``_¶¶``v¶¶¶v3¶¶–``o¶¶¶¶3`_¶¶``_¶¶¶``````o¶¶_`_¶¶¶qv¶¶o``o¶¶¶¶3`_¶¶``_¶¶¶```
```````````````````````````````````````````````8¶¶¶¶_`````````````````````````````````
``````````````````````````````````````````````````````````````````````````````````````
DDD
    def self.greetings
      print TITLE
    end

    def self.rules
      print 'bla'
    end

    def self.number_of_players
      print "Enter the numbers of players.\n"
    end

    def self.player_name(number)
      print "Enter the name of Player #{number}.\n"
    end

    def self.player_cash(number)
      print "Enter cash for Player #{number}"
    end

    def self.doing_bet(player_name)
      print "Player #{player_name}. What is your bet?\n"
    end

    def self.game_place(dealer, player)
      place = <<PPP
Dealer cards:
#{cards(dealer.cards)}
Dealer score: #{dealer.sums_cards.join(', ')}
Player #{player.name} cards:
#{hands(player.hands)}
PPP
    end

    def self.cards(cards)
      # d = ['+-----+', '|name   |', '|  suit  |', '|   name|',
      #  '+-----+', '+-----+', '|points|', '+-----+']
       d = CARD.each_with_object('') do |template, display|
        line = ''
        cards.each do |card|
          param = template.gsub(/[^a-z]/, '')
          if param.size.zero?
            line << template + ' '
            next
          end
          pre_value = card.send(param.to_sym)
          value = case param
                    when 'name'
                      pre_value.size == 1 ? ' ' + pre_value : pre_value
                    when 'suit'
                      SUITS[pre_value.to_sym]
                    when 'points'
                      pre_value = pre_value.join(' ') if pre_value.is_a?(Array)
                      pre_value + ' ' * (5 - pre_value.size)
                    end
            line << template.sub(param, value) + ' '
          end
        display << line + "\n"
      end
      print d
    end

    def self.hands(hands)
      text = ''
      hands.each_index do |index|
        print "Hand #{index + 1}:  bet -- #{hands[index].bet}\n"
        print "#{cards(hands[index].cards)}\n"
      end
      # print text
    end

    def self.player_win
      print 'Congratulations! You are winner!'
    end
  end
end

cards = [BlackJack::Card.new('As', [11, 1]), BlackJack::Card.new('7s', [7]), BlackJack::Card.new('10s', [10])]
cards_2 = [BlackJack::Card.new('As', [11, 1]), BlackJack::Card.new('7s', [7])]
# BlackJack::GameOutput.cards(cards)

hands = [BlackJack::Hand.new(cards), BlackJack::Hand.new(cards_2)]
hands.each { |hand| hand.add_bet(30)}
BlackJack::GameOutput.hands(hands)