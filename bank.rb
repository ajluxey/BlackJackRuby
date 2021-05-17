# frozen_string_literal: true

class Bank
  attr_reader :money

  def initialize
    @money = 0
  end

  def accept_bet(count)
    @money += count
  end

  def give_all_money
    tmp = @money
    @money = 0
    tmp
  end
end
