require_relative 'diller'
require_relative 'player'
require_relative 'bank'
require_relative 'deck'

class BlackJack
  def initialize
    @deck = Deck.new
    @bank = Bank.new
    start_game
  end

  def init_players
    puts 'Введите имя:'
    name = gets.chomp
    @player = Player.new(name)
    @diller = Diller.new
  end

  def start_game
    init_players
    2.times do
      @player.take_card(@deck.give_card)
      @diller.take_card(@deck.give_card)
    end
    @bank.accept_bet(@player.bet(10))
    @bank.accept_bet(@diller.bet(10))
    round
  end

  def round
    puts @player.cards
    puts @player.calculate_points
    puts @diller.cards
    puts @diller.calculate_points
  end
end

BlackJack.new