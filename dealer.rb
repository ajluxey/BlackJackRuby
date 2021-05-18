# frozen_string_literal: true

require_relative 'player'

class Dealer < Player
  def initialize
    super('Dealer')
    @cards_open = false
  end

  def make_a_move
    calculate_points >= 17 ? 1 : 2
  end
end
