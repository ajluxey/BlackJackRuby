# frozen_string_literal: true

class Deck
  attr_reader :cards

  def initialize
    suits = ['^', '+', '<>', '<3']
    values = Array(2..10).map(&:to_s) + %w[J Q K A]
    @cards = suits.product(values).map { |suit, value| value + suit }
  end

  def give_card
    @cards.delete_at(rand(@cards.length))
  end
end
