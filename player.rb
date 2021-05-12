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
    @cards.each do |card|
      if card.to_i != 0
        points += card.to_i
      else
        # сделать проверку на туза
        points += 10
      end
    end
    points
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
end