# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../lib/models/board'
require 'test/unit'

class BoardTest < Test::Unit::TestCase
  def setup
    @board = Board.new(6)
    p @board
  end

  def test_first
    assert_true(true)
  end
end
