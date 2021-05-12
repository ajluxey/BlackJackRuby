require_relative 'interface'

class Player
  attr_reader :name, :cards, :money, :cards_open

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
    @cards_open = true
  end

  def calculate_points
    points = 0
    ace_flag = false

    @cards.each do |card|
      if card.to_i != 0
        points += card.to_i
      else
        if card[0] == "A"
          ace_flag = true
        else
          points += 10
        end 
      end
    end
    ace_flag && points <= 10 ? points += 11 : points += 1 
  end

  def bet(count)
    @money -= count
    count
  end

  def skip
  end

  def take_card(card)
    @cards << card
    open_cards if @cards.length == 3
  end

  def open_cards
    @cards_open = true
  end

  def to_s
    puts "#{name}: #{calculate_points}"
  end
end