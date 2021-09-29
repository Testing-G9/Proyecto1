# frozen_string_literal: true

require 'matrix'
require_relative '../observer/observable'
require_relative './cell'

# Board class for denoting the board
class Board < Observable
  # rand(4)
  def initialize
    super()
    @size = 8
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
    notifyAll
  end

  def mark_cell(i_pos, j_pos)
    cell = get_cell(i_pos, j_pos)
    cell.discover
    notifyAll
  end

  def check_is_bomb(i_pos, j_pos)
    cell = get_cell(i_pos, j_pos)
    cell.is_bomb
  end

  attr_reader :matrix

  def get_cell(i_pos, j_pos)
    @matrix[j_pos][i_pos]
  end

  def get_neighbors_bombs(i_pos, j_pos)
    bomb_neighbors = 0
    (-1..1).each do |row|
      (-1..1).each do |col|
        border_condition = (i_pos + row).negative? || (j_pos + col).negative? || i_pos + row >= @size || col + j_pos >= @size
        bomb_neighbors += @matrix[i_pos + row][j_pos + col].is_bomb ? 1 : 0 unless border_condition
      end
    end
    bomb_neighbors
  end
end
