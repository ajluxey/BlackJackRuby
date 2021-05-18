# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    @cards = Array(0..3).product(Array(2..14)).map { |suit, value| Card.new(value, suit) }.shuffle
  end

  def give_card
    @cards.pop
  end
end
