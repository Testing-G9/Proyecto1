# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../lib/controllers/game'
require 'test/unit'
require 'mocha/test_unit'

# Class for testing the game controller
class GameTest < Test::Unit::TestCase
  def silenced
    $stdout = StringIO.new
    yield
  ensure
    $stdout = STDOUT
  end

  def setup
    srand(31_415)
    silenced do
      @game = GameController.new(6)
    end
  end

  def test_check_loss
    @game.model.expects(:unveil_bombs).returns.at_least_once
    @game.view.expects(:game_over).returns.at_least_once

    @game.check_loss(0, 0)
    assert_equal(@game.loss, false)
    @game.check_loss(5, 5)
    assert_equal(@game.loss, true)
  end

  def test_mark_cell
    silenced do
      @game.mark_cell(3, 3)
    end
    assert_equal(true, @game.model.matrix[3][3].is_open)
    @game.model.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        assert_equal(false, cell.is_open, 'Cell is unveiled incorrectly') unless j == 3 && i == 3
      end
    end
  end

  def test_check_win
    @game.model.expects(:unveil_bombs).returns.at_least_once
    @game.model.matrix.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        silenced do
          @game.model.mark_cell(i, j) unless cell.is_open || cell.is_bomb
        end
      end
    end
    assert_equal(true, @game.check_win)
  end
end
