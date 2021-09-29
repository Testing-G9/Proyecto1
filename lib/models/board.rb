# frozen_string_literal: true

require 'matrix'
require_relative '../observer/observable'
require_relative './cell'

# Board class for denoting the board
class Board < Observable
  attr_accessor :matrix

  def initialize(size)
    super()
    @size = size
    @matrix = []
    init_board
  end

  def init_board
    @matrix = Array.new(@size) { Array.new(@size) { Cell.new } }
    @matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        cell.neighbor_bombs = get_neighbors_bombs(i, j)
      end
    end
  end

  def check_border_condition(x_pos, y_pos, row, col)
    (x_pos + row).negative? || (y_pos + col).negative? || x_pos + row >= @size || col + y_pos >= @size
  end

  def get_neighbors_bombs(x_pos, y_pos)
    bomb_neighbors = 0
    (-1..1).each do |row|
      (-1..1).each do |col|
        border_condition = check_border_condition(x_pos, y_pos, row, col)
        bomb_neighbors += @matrix[x_pos + row][y_pos + col].is_bomb ? 1 : 0 unless border_condition
      end
    end
    bomb_neighbors
  end
end
