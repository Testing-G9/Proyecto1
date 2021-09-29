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
    printBoard
    requestInput
  end

  def printBoard
    @view.clean
    @view.printBoard(@model)
  end

  def select(x, y)
    @model.mark(x,y)
  end

  def requestInput
    @view.printOptions
    key = $stdin.gets.to_i
    x = key
    y = key
    select(x, y)
  end

end
