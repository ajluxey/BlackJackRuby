# frozen_string_literal: true

require_relative 'diller'
require_relative 'player'
require_relative 'bank'
require_relative 'deck'
require_relative 'interface'
require_relative 'player_moves'

class BlackJack
  POSSIBLE_MOVES = ['Пропустить', 'Взять карту', 'Открыть карты'].freeze
  START_INDEX = 1
  EXIT_INDEX = 2

  BET = 10

  def initialize
    @deck = Deck.new
    @bank = Bank.new
    @interface = Interface.new
    run
  end

  def run
    first_start = true
    init_players

    begin
      game_index = @interface.main_menu(first_start)
    rescue StandardError
      puts 'Неправильный пункт, попробуйте снова'
      retry
    end

    first_start = false
    loop do
      case game_index
      when START_INDEX
        break unless start_game
      when EXIT_INDEX
        break
      end

      begin
        game_index = @interface.main_menu(first_start)
      rescue StandardError
        puts 'Неправильный пункт, попробуйте снова'
        retry
      end

      @deck = Deck.new
      @player1.restart
      @player2.restart
    end
  end

  def init_players
    begin
      name = @interface.ask_name
    rescue StandardError
      puts 'Без имени играть нельзя'
      retry
    end
    @player1 = Player.new(name)
    @player2 = Diller.new
  end

  def start_game
    2.times do
      @player1.take_card(@deck.give_card)
      @player2.take_card(@deck.give_card)
    end

    # return если не хватает деняк
    return false unless players_place_bet

    next_player_move = [@player1, @player2]

    @interface.draw_the_game(@player1, @player2, @bank)
    @interface.draw_turn(next_player_move.first)

    while move(next_player_move.first)
      @interface.draw_the_game(@player1, @player2, @bank)
      @interface.draw_turn(next_player_move.last)
      next_player_move.reverse!
    end
    choose_winner
    true
  end

  def players_place_bet
    @bank.accept_bet(@player1.bet(BET))
    @bank.accept_bet(@player2.bet(BET))
    true
  rescue StandardError
    puts 'Недостаточно денег у одного из игроков, игра заканчивается'
    false
  end

  def return_bets
    @player1.get_money(BET)
    @player2.get_money(BET)
  end

  def move(player)
    return false if @player1.cards.length == 3 && @player2.cards.length == 3

    if player == @player1
      begin
        move_name = @interface.ask_about_move(player.availabel_moves)
      rescue StandardError
        puts 'Неправильно выбран пункт'
        retry
      end
      p_move = player.get_move_by_name(move_name)
    else
      move_index = player.make_a_move
      p_move = player.get_move_by_index(move_index)
    end
    send(p_move, player)
  end

  def move_skip(player)
    player.skip
    true
  end

  def move_take_card(player)
    player.take_card(@deck.give_card)
    true
  end

  def move_open_cards(_player)
    @player1.open_cards
    @player2.open_cards
    false
  end

  def choose_winner
    p1_points = @player1.calculate_points
    p2_points = @player2.calculate_points
    if (p1_points > 21 && p2_points > 21) || p1_points == p2_points
      return_bets
      @interface.draw_the_results(nil)
    elsif p1_points > 21
      @player2.get_money(@bank.give_all_money)
      @interface.draw_the_results(@player2)
    elsif p2_points > 21
      @player1.get_money(@bank.give_all_money)
      @interface.draw_the_results(@player1)
    elsif (21 - p1_points) < (21 - p2_points)
      @player1.get_money(@bank.give_all_money)
      @interface.draw_the_results(@player1)
    else
      @player2.get_money(@bank.give_all_money)
      @interface.draw_the_results(@player2)
    end
    move_open_cards(nil)
    @interface.draw_the_game(@player1, @player2, @bank)
  end
end

BlackJack.new
