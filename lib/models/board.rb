# frozen_string_literal: true

require 'matrix'
require_relative '../observer/observable'
require_relative './cell'

# Board class for denoting the board
class Board < Observable
  attr_accessor :matrix, :size

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
    notify_all
  end

  def border_condition(i_pos, j_pos, row, col)
    (i_pos + row).negative? ||
      (j_pos + col).negative? ||
      i_pos + row >= @size    ||
      col + j_pos >= @size
  end

  def discovered_condition(i_pos, j_pos, row, col)
    cell = get_cell(i_pos + row, j_pos + col)
    cell.is_open
  end

  def orthogonal?(row, col)
    row.abs ^ col.abs
  end

  def unveal_position_check(i_pos, j_pos, row, col)
    if !border_condition(i_pos, j_pos, row, col)
      cell = get_cell(i_pos + row, j_pos + col)

    border_condition(i_pos, j_pos, row, col) ||
      discovered_condition(i_pos, j_pos, row, col) ||
        orthogonal?(row, col).zero? ||
        cell.is_bomb
    else
      true
    end
  end

  def discover_board(i_pos, j_pos)
    [-1, 0, 1].repeated_permutation(2).each do |row, col|
      next if unveal_position_check(i_pos, j_pos, row, col)

      cell = get_cell(i_pos + row, j_pos + col)
      cell.discover
      discover_board(i_pos + row, j_pos + col) unless cell.neighbor_bombs.positive?
    end
  end
  end

  def mark_cell(i_pos, j_pos)
    discover_cell(i_pos, j_pos)
    cell = get_cell(i_pos, j_pos)
    discover_board(i_pos, j_pos) unless cell.neighbor_bombs.positive? || cell.is_bomb
    notify_all
  end

  def discover_cell(i_pos, j_pos)
    cell = get_cell(i_pos, j_pos)
    cell.discover
    # notify_all
  end

  def check_is_bomb(i_pos, j_pos)
    cell = get_cell(i_pos, j_pos)
    cell.is_bomb
  end

  def get_cell(i_pos, j_pos)
    @matrix[i_pos][j_pos]
  end

  def get_neighbors_bombs(i_pos, j_pos)
    bomb_neighbors = 0
    (-1..1).each do |row|
      (-1..1).each do |col|
        next if border_condition(i_pos, j_pos, row, col) || row.zero? && col.zero?

        bomb_neighbors += @matrix[i_pos + row][j_pos + col].is_bomb ? 1 : 0
      end
    end
    bomb_neighbors
  end
end
