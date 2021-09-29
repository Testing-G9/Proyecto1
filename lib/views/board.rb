# frozen_string_literal: true

require 'matrix'
require_relative '../observer/observer'

class BoardView < Observer
  def update(boardModel)
    clean
    print_board(boardModel)
  end

  def print_board(boardModel)
    print '   '
    (0...8).each do |digit|
      print "_#{digit}_"
    end
    print "\n"
    boardModel.matrix.each_with_index do |row, index|
      print " #{index}|"
      row.each do |cell|
        print cell
      end
      print "\n"
    end
  end

  def congratulate(player_symbol)
    # TODO
  end

  def game_over
    print "You lost \n"
  end

  def clean
    # TODO
  end

  def print_options
    print "Select position (x,y)\n"
  end
end
