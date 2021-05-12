require_relative 'player'

class Diller < Player
  def initialize
    super('Diller')
  end

  def make_move
    if calculate_points >= 17
      skip
    else
      take_card
    end
  end
end
