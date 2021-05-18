class Hand
  attr_reader :hand, :cards

  JACKET = 11
  ACE = 14

  def initialize
    @cards = []
  end

  def calculate_points
    points = 0
    aces_count = 0

    @cards.each do |card|
      if card.value < JACKET
        points += value
      elsif card.value < ACE:
        aces_count += 1
      else
        points += 10
      end
    end
    if aces_count != 0
      aces_count.times { points += points <= 10 ? 11 : 1 }
    end
    points
  end

  def take_card(card)
    @cards << card
    raise "More than 3 card" if @cards.length > 3
  end
end
