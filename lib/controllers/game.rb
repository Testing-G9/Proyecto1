# frozen_string_literal: true

require_relative '../models/board'
require_relative '../views/board'
require 'matrix'

# Game controller implementation
class GameController
  def initialize
    @model = Board.new(6)
    @view = BoardView.new
    @model.addObserver(@view)
  end

  def print_board
    # @view.clean
    # @view.printBoard(@model)
  end

  def request_input
    # @view.printOptions(playerSymbol)
    # key = $stdin.gets.to_i
    # x = (key / 3.0).ceil
    # y = (key % 3).to_i
    # y = 3 if y.zero?
    # select(x, y)
  end
end
