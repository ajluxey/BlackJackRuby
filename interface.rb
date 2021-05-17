# frozen_string_literal: true

class Interface
  def initialize
    puts 'Игра BlackJack'
  end

  def main_menu(first_start)
    if first_start
      menu(['Начать игру', 'Выйти'])
    else
      menu(%w[Повторить Выйти])
    end
  rescue Exception => e
    raise e
  end

  def ask_name
    puts 'Введите имя:'
    name = gets.chomp
    raise 'Не введено имя' if name.empty?

    name
  end

  def ask_about_move(moves)
    res = menu(moves)
    res == -1 ? res : moves[res - 1]
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
