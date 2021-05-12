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
      init_players
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
    2.times do
      @player1.take_card(@deck.give_card)
      @player2.take_card(@deck.give_card)
    end
    @bank.accept_bet(@player1.bet(10))
    @bank.accept_bet(@player2.bet(10))
    
    @interface.draw_game(@player1, @player2, @bank)

    while round
      if @player1.cards.length == 3 and @player2.length == 3
      end
    end
    choose_winner
  end

  def round
    p1_decision = @interface.ask_about_move
    do_move_by_index(@player1, p1_decision)
    @interface.draw_game(@player1, @player2, @bank)

    if p1_decision != 3
      p2_decision = @player2.make_a_move
      do_move_by_index(@player2, p2_decision)
      @interface.draw_game(@player1, @player2, @bank)
    else
      return false
    end
    true
  end

  def do_move_by_index(player, move_index)
    case move_index
    when 2
      player.take_card(@deck.give_card)
    when 3
      @player1.open_cards
      @player2.open_cards
    end
  end
end

BlackJack.new
