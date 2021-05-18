# frozen_string_literal: true

require_relative 'player'

class Interface
  START_INDEX = 1
  EXIT_INDEX = 2

  def initialize(game)
    @game = game
    open_game
  end

  private

  def open_game
    puts 'Игра BlackJack'
    first_game = true
    loop do
      point = menu(['Начать игру', 'Выйти'])
      case point
      when START_INDEX
        if first_game
          init_players
          first_game = false
        end
        start_game
      when EXIT_INDEX
        break
      end
      @game.restart
      puts 'Сыграть снова?'
    end
  end

  def start_game
    @game.players_place_bet

    begin
      @game.deal_initial_card
    rescue StandardError
      puts 'У одного из игроков уже были карты'
      return
    end

    @game.can_running?
    round while @game.is_running

    draw_the_game(*@game.get_round_info)
    winner = @game.choose_winner
    draw_the_results(winner)
    @game.open_cards(nil)
    draw_the_game(*@game.get_round_info)
  end

  def init_players
    begin
      name = ask_name
    rescue StandardError
      puts 'Без имени играть нельзя'
      retry
    end
    @game.init_players(name)
  end

  def round
    player = @game.players_order.first
    draw_turn(player)
    if player == @game.player1
      draw_the_game(*@game.get_round_info)
      move_name = ask_about_move(player.availabel_moves)
      player.next_move = player.get_move_by(move_name)
    end
    @game.round
  end

  def ask_name
    puts 'Введите имя:'
    name = gets.chomp
    raise 'Не введено имя' if name.empty?

    name
  end

  def ask_about_move(moves)
    res = menu(moves)
  rescue StandardError
    puts 'Неправильный пункт'
    retry
  else
    move = moves[res - 1]
  end

  def draw_turn(player)
    puts
    puts '***'
    puts "#{player.name} turn!"
    puts '***'
    puts
  end

  def draw_the_game(p1, p2, bank)
    puts '***'
    puts "In bank: #{bank.money}$"
    puts

    puts str_stats_of(p1)
    puts
    puts str_stats_of(p2)

    puts '***'
  end

  def draw_the_results(winner)
    if winner
      puts '***'
      puts "Победил игрок #{winner.name}!!"
      puts '***'
    else
      puts '***'
      puts 'Это ничья! Деньги возвращаются.'
      puts '***'
    end
  end

  def menu(points)
    points.each_with_index do |point, index|
      puts "#{index + 1}. #{point}"
    end
    point = gets.chomp.to_i
    raise 'Неправильный пункт' unless (1..points.size).include? point

    point
  end

  def str_stats_of(player)
    return '' if player.nil?

    str = ''
    str += "Player #{player.name}\n"
    str += "Money: #{player.money}\n"
    str += "Cards: #{get_str_of_cards(player)}\n"
    str += "Points: #{player.points}" if player.cards_open
    str
  end

  def get_str_of_cards(player)
    if player.cards_open
      player.hand.cards.join(', ')
    else
      '* ' * player.hand.cards.length
    end
  end
end
