# frozen_string_literal: true

require_relative 'player_moves'
require_relative 'hand.rb'

class Player
  attr_reader :name, :money, :points, :cards_open

  include PlayerMoves

  def initialize(name)
    @name = name
    @money = 100
    @hand = Hand.new()
    @points = 0
    @cards_open = true
  end

  def bet(count)
    @money -= count
    raise "From #{self}: Not enough money" if @money.negative?

    count
  end

  def get_money(count)
    @money += count
    count
  end

  def skip; end

  def take_card(card)
    @hand.take_card(card)
    @points = @hand.calculate_points
  end

  def open_cards
    @cards_open = true
  end

  def restart
    @cards_open = false
    @cards = []
  end
end
