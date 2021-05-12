class Player
  attr_reader :name
  attr_reader :cards

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
  end

  def make_move
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
    @money - count
    count
  end

  def take_card(card)
    @cards << card
  end

  def skip
    puts 'skip'
  end

  def open_cards
    puts 'open'
  end

  def to_s
    puts "#{name}: #{calculate_points}"
  end
end
