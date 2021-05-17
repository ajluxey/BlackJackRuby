# frozen_string_literal: true

module PlayerMoves
  '''
  Небольшой кусок логики
  Возможные ходы:
    Пропустить > ход переходит следующему
    Добавить карту (если у игрока 2 карты) > ход переходит следующему
    Открыть карты > конец игры
  '''
  MOVES_BY_NAME = { 'Пропуск хода' => :move_skip,
                    'Взять карту' => :move_take_card,
                    'Открыть карты' => :move_open_cards }.freeze

  MOVES_BY_INDEX = { 1 => :move_skip,
                     2 => :move_take_card,
                     3 => :move_open_cards }.freeze

  def availabel_moves
    availabel_moves = MOVES_BY_NAME.keys
    availabel_moves.delete('Взять карту') if cards.length > 2
    availabel_moves
  end

  def get_move_by_name(name)
    MOVES_BY_NAME[name]
  end

  def get_move_by_index(index)
    MOVES_BY_INDEX[index]
  end
end
