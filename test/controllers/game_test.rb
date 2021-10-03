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

  def test_player_turn
    io = StringIO.new('3,4')
    $stdin = io
    @game.player_turn
  end
end
