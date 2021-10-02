# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../lib/models/board'
require 'test/unit'

# rubocop:disable Metrics/ClassLength
# Class for testing the board model
class BoardTest < Test::Unit::TestCase
  def setup
    srand(31_415)
    @size = 6
    @board = Board.new(@size)
    @expected = [[0, 0, 0, 0, 0, 0],
                 [1, 2, 1, 1, 0, 0],
                 [1, 3, 1, 2, 1, 1],
                 [3, 3, 2, 2, 0, 1],
                 [2, 3, 3, 3, 4, 3],
                 [2, 1, 2, 1, 2, 1]]
  end

  def test_board_size
    assert_equal(@board.matrix.length, 6, 'Board height is not as expected')
    assert_equal(@board.matrix[0].length, 6, 'Board width was not as expected')
  end

  def test_board_neighbors_data
    @board.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        assert_equal(cell.neighbor_bombs, @expected[i][j], 'Incorrect amount of bombs around cell')
      end
    end
  end

  def test_get_cell
    @board.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        assert_equal(cell, @board.get_cell(i, j), 'Incorrect cell gotten from board')
      end
    end
  end

  def test_discover_cell
    @board.discover_cell(1, 1)
    assert_equal(true, @board.matrix[1][1].is_open)
    @board.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        assert_equal(false, cell.is_open, 'Cell is unveiled incorrectly') unless j == 1 && i == 1
      end
    end
  end

  def test_discover_cell_recursive
    @board.discover_board(0, 0)
    @board.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if [0, 1].include?(i) || [[2, 4], [2, 5]].include?([i, j])
          assert_equal(true, cell.is_open, 'Cell is unveiled incorrectly')
        else
          assert_equal(false, cell.is_open, 'Cell is unveiled incorrectly')
        end
      end
    end
  end

  def test_check_is_bomb
    @board.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        assert_equal(cell.is_bomb, @board.check_is_bomb(i, j), 'Bomb reported incorrectly')
      end
    end
  end

  def test_mark_cell_discover
    @board.mark_cell(0, 1)
    assert_equal(true, @board.get_cell(0, 1).is_open, 'Cell is unveiled incorrectly')
    assert_equal(true, @board.get_cell(0, 0).is_open, 'Cell is unveiled incorrectly')
    assert_equal(true, @board.get_cell(0, 2).is_open, 'Cell is unveiled incorrectly')
    assert_equal(false, @board.get_cell(3, 2).is_open, 'Cell is unveiled incorrectly')
  end

  def test_border_condition
    size_arr = *(-1...@size)
    size_arr.repeated_permutation(4).each do |i_pos, j_pos, row, col|
      condition = (i_pos + row).between?(0, @size - 1) && (j_pos + col).between?(0, @size - 1)
      assert_equal(!condition, @board.border_condition(i_pos, j_pos, row, col))
    end
  end

  def test_orthogonal
    neighbor_arr = *(-1..1)
    neighbor_arr.repeated_permutation(2).each do |i_pos, j_pos|
      condition = (i_pos - j_pos).abs == 1
      assert_equal(!condition, @board.orthogonal?(i_pos, j_pos).zero?)
    end
  end

  # rubocop:disable Metrics/AbcSize
  def test_discovered_condition
    @board.discover_cell(1, 1)
    neighbor_arr = *(-1..1)
    matrix_arr = *(0...@size)
    matrix_arr.repeated_permutation(2).each do |i, j|
      neighbor_arr.repeated_permutation(2).each do |i_pos, j_pos|
        next unless (i + i_pos).between?(0, @size - 1) && (j + j_pos).between?(0, @size - 1)

        assert_equal(i == 1 && j == 1, @board.discovered_condition(i_pos, j_pos, i - i_pos, j - j_pos),
                     'Neighbor Cell is unveiled incorrectly')
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  def test_unveil_bombs
    @board.unveil_bombs
    @board.matrix.each do |row|
      row.each do |cell|
        assert_equal(cell.is_open, true) if cell.is_bomb
      end
    end
  end

  def test_unveil_position_check_border
    assert_equal(true, @board.unveil_position_check(0, 1, -1, 0), 'Border condition incorrect')
    assert_equal(true, @board.unveil_position_check(1, 0, 0, -1), 'Border condition incorrect')
    assert_equal(true, @board.unveil_position_check(5, 0, 1, 0), 'Border condition incorrect')
    assert_equal(true, @board.unveil_position_check(0, 5, 0, 1), 'Border condition incorrect')
  end

  def test_win
    @board.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        @board.mark_cell(i,j) unless cell.is_open || cell.is_bomb
      end
    end
    assert_equal(true, @board.check_winning_condition)
  end
end
# rubocop:enable Metrics/ClassLength
