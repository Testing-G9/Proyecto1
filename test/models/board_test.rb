# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../lib/models/board'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def setup
    srand(31_415)
    @board = Board.new(6)
    @expected = [
      [0, 0, 0, 0, 0, 0],
      [1, 2, 1, 1, 0, 0],
      [1, 2, 1, 2, 1, 1],
      [2, 3, 1, 2, 1, 1],
      [1, 1, 1, 3, 3, 2],
      [1, 1, 1, 2, 2, 1]
    ]
  end

  def test_board_size
    assert_equal(@board.matrix.length, 6, 'Board height is not as expected')
    assert_equal(@board.matrix[0].length, 6, 'Board width was not as expected')
  end

  def test_board_neighbors_data
    @board.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        puts "#{cell.neighbor_bombs} #{@expected[i][j]}"
        assert_equal(cell.neighbor_bombs, @expected[i][j], 'Incorrect amount of bombs around cell')
      end
    end
  end
end