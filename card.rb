class Card
  attr_reader :value
  
  SUITS = {0 => '^',
           1 => '+',
           2 => '<>',
           3 => '<3'}
  
  VALUES = {11 => 'J',
            12 => 'Q',
            13 => 'K',
            14 => 'A'}

  def initialize(value, suit)
    raise "Неправильно задана карта" if !value.between?(2, 14) || !suit.between?(0, 3) 
    @value = value
    @suit = suit
  end

  def to_s
    if VALUES.include? @value
      VALUES[@value] + SUITS[@suit]
    else
      @value.to_s + SUITS[@suit]
    end
  end
end