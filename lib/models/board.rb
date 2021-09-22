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

    @matrix.each do |row|
      row.each do |cell|
        print cell.is_bomb ? 'X' : cell.neighbor_bombs
      end
      print "\n"
    end
  end

  def get_neighbors_bombs(i, j)
    bomb_neighbors = 0
    (-1..1).each do |row|
      (-1..1).each do |col|
        border_condition = (i + row).negative? || (j + col).negative? || i + row >= @size || col + j >= @size 
        bomb_neighbors += @matrix[i + row][j + col].is_bomb ? 1 : 0 unless border_condition
      end
    end
    bomb_neighbors
  end  
end
