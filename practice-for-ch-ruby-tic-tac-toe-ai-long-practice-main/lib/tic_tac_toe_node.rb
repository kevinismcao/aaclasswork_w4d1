require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos 
  end

  def losing_node?(evaluator)
    
  end

  def winning_node?(evaluator)

  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_mark = (next_mover_mark == :x ? :o : :x)
    nodes = []
    board.dup.open_positions.each do |child_pos|
      new_board = board.dup
      new_board[child_pos] = child_mark
      nodes << TicTacToeNode.new(new_board, child_mark, child_pos)
    end
    nodes
  end
end