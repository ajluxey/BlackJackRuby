# frozen_string_literal: true

require_relative 'player'

class Dealer < Player
  def initialize
    super('Dealer')
    @cards_open = false
  end

  def decide_of_the_move
    calculate_points >= 17 ? :skip : :take_card
  end
end
