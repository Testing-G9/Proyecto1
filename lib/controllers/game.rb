# frozen_string_literal: true

require_relative '../models/board'
require_relative '../views/board'
require 'matrix'

# game controller for managing view and model
class GameController
  def initialize
    @model = Board.new(6)
    @view = BoardView.new
    @model.add_observer(@view)
    @loss = false
    print_board
  end

  def print_board
    @view.clean
    @view.print_board(@model)
  end

  def player_turn
    x, y = request_input
    mark_cell(x, y)
    check_loss(x, y)
  end

  attr_reader :loss

  def check_loss(i_pos, j_pos)
    @loss = @model.check_is_bomb(i_pos, j_pos)
    @view.game_over if @loss
  end

  def mark_cell(i_pos, j_pos)
    @model.mark_cell(i_pos, j_pos)
  end

  def request_input
    loop do
      @view.print_options
      keys = gets.split(',')
      x = keys[0].to_i
      y = keys[1].to_i
      return x, y if (x < 8) && (y < 8)
    end
  end
end
