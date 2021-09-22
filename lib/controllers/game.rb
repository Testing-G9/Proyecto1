# frozen_string_literal: true

require_relative '../models/board'
require_relative '../views/board'
require 'matrix'

# 
class GameController
  def initialize
    @model = Board.new()
    @view = BoardView.new()
    @model.addObserver(@view)
  end

  def printBoard
    # @view.clean
    # @view.printBoard(@model)
  end

  def requestInput
    # @view.printOptions(playerSymbol)
    # key = $stdin.gets.to_i
    # x = (key / 3.0).ceil
    # y = (key % 3).to_i
    # y = 3 if y.zero?
    # select(x, y)
  end

end
