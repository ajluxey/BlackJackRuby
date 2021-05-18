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
    point = menu(['Начать игру', 'Выйти'])
    case point
    when START_INDEX
      start_game
    when EXIT_INDEX
      exit
    end
  end

  def start_game
    init_players
    @game.players_place_bet

    begin
      @game.deal_initial_card
    rescue
      puts "У одного из игроков уже были карты"
      return
    end

    game_is_running = True
    while game_is_running
      game_is_running = round
    end
  end

  def init_player
    begin
      name = ask_name
    rescue
      puts "Без имени играть нельзя"
      retry
    end
    @game.init_players(name)
  end

  def round
    player = @game.players_order.first
    draw_turn(player)
    draw_the_game(*@game.get_round_info)
    if player.is_a? Player
      move_name = ask_about_move(player.availabel_moves)
      player.next_move = player.MOVES_BY_NAME[move_name]
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
  rescue
    puts "Неправильный пункт"
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

    puts "Player #{p1.name}"
    puts "Your money: #{p1.money}$"
    puts "Your cards: #{get_str_of_cards(p1)}"
    puts "Your points: #{p1.calculate_points}"
    puts

    puts "\Player #{p2.name}"
    puts "Money: #{p2.money}$"
    puts "Cards: #{get_str_of_cards(p2)}"
    puts "Points: #{p2.calculate_points}" if p2.cards_open
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

  private

  def menu(points)
    points.each_with_index do |point, index|
      puts "#{index + 1}. #{point}"
    end
    point = gets.chomp.to_i
    raise 'Неправильный пункт' unless (1..points.size).include? point

    point
  end

  def get_str_of_cards(player)
    if player.cards_open
      player.cards.join(', ')
    else
      '* ' * player.cards.length
    end
  end
end
