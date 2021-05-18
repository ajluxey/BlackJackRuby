# frozen_string_literal: true

require_relative 'dealer'
require_relative 'player'
require_relative 'bank'
require_relative 'deck'
require_relative 'interface'
require_relative 'player_moves'

class GameLogic
  attr_reader :players_order,

  BET = 10

  def initialize
    @deck = Deck.new
    @bank = Bank.new
  end    

  def init_players(name)
    @player1 = Player.new(name)
    @player2 = Dealer.new
    @players_order = [@player1, @player2]
  end

  def deal_initial_card
    raise "У игроков уже есть карты" if player1.hand.cards.length > 0 || player2.cards.length > 0
    2.times do
      @player1.take_card(@deck.give_card)
      @player2.take_card(@deck.give_card)
    end
  end

  def players_place_bet
    @bank.accept_bet(@player1.bet(BET))
    @bank.accept_bet(@player2.bet(BET))
  end

  def return_bets
    @player1.get_money(BET)
    @player2.get_money(BET)
  end

  def round
    player = @players_order.first
    player_move = player.decide_of_the_move
    send(player_move, player)
    players_order.reverse!
  end

  def skip(player)
    player.skip
  end

  def take_card(player)
    player.take_card(@deck.give_card)
  end

  def open_cards(_)
    @player1.open_cards
    @player2.open_cards
  end

  def choose_winner
    if (@player1.points > 21 && @player2.points > 21) || @player1.points == @player2.points
      return
    elsif @player1.points > 21
      @player2.get_money(@bank.give_all_money)
      return @player2
    elsif @player2.points > 21
      @player1.get_money(@bank.give_all_money)
      return @player1
    elsif (21 - @player1.points) < (21 - @player2.points)
      @player1.get_money(@bank.give_all_money)
      return @player1
    else
      @player2.get_money(@bank.give_all_money)
      return @player2
    end
    move_open_cards(nil)
  end

  def get_round_info
    @player1, @player2, @bank
  end
end

BlackJack.new
