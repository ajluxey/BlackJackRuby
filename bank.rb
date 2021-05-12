class Bank
  attr_reader :money

  def initialize
    @money = 0
  end

  def accept_bet(count)
    @money += count
  end
end