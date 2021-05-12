class Bank
  def initialize
    @bank = 0
  end

  def accept_bet(count)
    @bank += count
  end
end