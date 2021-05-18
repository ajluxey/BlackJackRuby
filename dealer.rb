# frozen_string_literal: true

require_relative 'player'

class Dealer < Player
  def initialize
    super('Dealer')
    @cards_open = false
  end

  def decide_of_the_move
    @points >= 17 ? :skip : :take_card
  end

  def restart
    @cards_open = false
    @hand.cards = []
  end
end
