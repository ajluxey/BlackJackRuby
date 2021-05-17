# frozen_string_literal: true

require_relative 'player_moves'

class Player
  attr_reader :name, :cards, :money, :cards_open

  include PlayerMoves

  def initialize(name)
    @name = name
    @money = 100
    @cards = []
    @cards_open = true
  end

  def calculate_points
    points = 0
    ace_flag = false

    @cards.each do |card|
      if card.to_i != 0
        points += card.to_i
      elsif card[0] == 'A'
        ace_flag = true
      else
        points += 10
      end
    end
    if ace_flag
      points += points <= 10 ? 11 : 1
    end
    points
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
    @cards << card
    raise "from #{self}: Player have more than 3 card" if @cards.length > 3
  end

  def open_cards
    @cards_open = true
  end

  def restart
    @cards_open = false
    @cards = []
  end
end
