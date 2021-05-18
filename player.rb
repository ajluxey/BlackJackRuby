# frozen_string_literal: true

require_relative 'hand'

class Player
  attr_reader :name, :money, :points, :cards_open, :hand
  attr_accessor :next_move

  MOVES_BY_NAME = { 'Пропуск хода' => :skip,
                    'Взять карту' => :take_card,
                    'Открыть карты' => :open_cards }.freeze

  def initialize(name)
    @name = name
    @money = 100
    @hand = Hand.new()
    @points = 0
    @cards_open = true
  end

  def availabel_moves
    availabel_moves = MOVES_BY_NAME.keys
    availabel_moves.delete('Взять карту') if @hand.cards.length > 2
    availabel_moves
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

  def decide_of_the_move
    @next_move
  end

  def skip; end

  def take_card(card)
    @hand.take_card(card)
    @points = @hand.calculate_points
  end

  def open_cards
    @cards_open = true
  end

  def get_move_by(name)
    MOVES_BY_NAME[name]
  end

  def restart
    @cards_open = true
    @hand.cards = []
  end
end
