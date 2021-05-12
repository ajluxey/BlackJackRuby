class Interface
  def initialize
    puts 'Игра BlackJack'
  end

  def main_menu
    menu(['Начать игру', 'Выйти'])
  end
  
  def ask_name
    puts 'Введите имя:'
    name = gets.chomp
  end

  def draw_game(p1, p2, bank)
    puts '***'
    puts "In bank: #{bank.money}$"
    puts
    
    puts "Player #{p1.name}"
    puts "Your money: #{p1.money}$"
    puts "Your cards: " + get_str_of_cards(p1, true)
    puts "Your points: #{p1.calculate_points}"
    puts

    puts "\Player #{p2.name}"
    puts "Money: #{p2.money}$"
    puts "Cards: " + get_str_of_cards(p2, false)
    puts '***'
  end

  def get_str_of_cards(player, open)
    if open
      str =  player.cards.join(', ')
    else
      str = '* ' * player.cards.length
    end
    str
  end

  private

  # return -1 if uncorrect value
  def menu(points)
    points.each_with_index do |point, index|
      puts "#{(index + 1).to_s}. #{point}"
    end

    point = gets.chomp.to_i
    point = -1 unless (1..points.size).include? point
    point
  end
end