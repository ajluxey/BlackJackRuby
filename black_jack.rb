require_relative 'diller'
require_relative 'player'
require_relative 'bank'
require_relative 'deck'
require_relative 'interface'

class BlackJack
  OPTIONS_OF_MOVE = ['Взять карту', 'Пропустить', 'Открыть карты']

  def initialize
    @deck = Deck.new
    @bank = Bank.new
    @interface = Interface.new
    run
  end

  def run
    if @interface.main_menu == 1
      start_game
    else
      exit
    end
  end

  def init_players
    @player1 = Player.new(@interface.ask_name)
    @player2 = Diller.new
  end

  def start_game
    init_players
    2.times do
      @player1.take_card(@deck.give_card)
      @player2.take_card(@deck.give_card)
    end
    @bank.accept_bet(@player1.bet(10))
    @bank.accept_bet(@player2.bet(10))
    
    @interface.draw_game(@player1, @player2, @bank)
  end

  def round
    @player1.make_move
  end
end

BlackJack.new
