module BlackJack
  module Rules
    MIN_BET = 10
    MIN_CASH = 0
    BLACK_JACK = 21
    BET = { black_jack: 1.5, push: 1 }.freeze
    DOUBLE_SUM = [10, 11]
    PLAYER_NAME = { more: 2, less: 11 }
    PLAYER_CASH = { more: MIN_BET, less: 50000 }
    PLAYER_ACTION = [:hit, :split, :double]
    PLAYER_YES_NO = [:yes, :no]
  end
end
