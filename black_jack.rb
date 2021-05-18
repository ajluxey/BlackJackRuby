require_relative 'game_logic'
require_relative 'interface'

class BlackJack
  def initialize
    game = GameLogic.new()
    Interface.new(game)
  end
end

BlackJack.new
