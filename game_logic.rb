# frozen_string_literal: true

require_relative 'dealer'
require_relative 'player'
require_relative 'bank'
require_relative 'deck'
require_relative 'interface'

class GameLogic
  attr_reader :player1, :players_order, :is_running

  BET = 10

  def initialize
    @deck = Deck.new
    @bank = Bank.new
    @is_running = true
  end

  def init_players(name)
    @player1 = Player.new(name)
    @player2 = Dealer.new
    @players_order = [@player1, @player2]
  end

  def deal_initial_card
    raise 'У игроков уже есть карты' if @player1.hand.cards.length.positive? || @player2.hand.cards.length.positive?

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
    @player1.get_money(@bank.get_money(BET))
    @player2.get_money(@bank.get_money(BET))
  end

  def round
    return unless can_running?

    player = @players_order.first
    player_move = player.decide_of_the_move
    players_order.reverse!
    send(player_move, player)
  end

  def can_running?
    if @player1.nil? || @player2.nil? || (@player1.hand.cards.length > 2 && @player2.hand.cards.length > 2)
      @is_running = false
    end
    @is_running
  end

  def skip(player)
    player.skip
    @is_running = true
  end

  def take_card(player)
    player.take_card(@deck.give_card)
    can_running?
  end

  def open_cards(_)
    @player1.open_cards
    @player2.open_cards
    @is_running = false
  end

  def restart
    @player1.restart
    @player2.restart
    @deck = Deck.new
    @players_order = [@player1, @player2]
    @is_running = true
  end

  def choose_winner
    if (@player1.points > 21 && @player2.points > 21) || @player1.points == @player2.points
      return_bets
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
    [@player1, @player2, @bank]
  end
end
