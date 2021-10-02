# frozen_string_literal: true

require 'matrix'
require_relative '../observer/observer'

# board game view
class BoardView < Observer
  def update(board_model)
    clean
    print_board(board_model)
  end

  def print_board(board_model)
    print '   '
    (0...board_model.size).each do |digit|
      print "_#{digit}_"
    end
    print "\n"
    board_model.matrix.each_with_index do |row, index|
      print " #{index}|"
      row.each do |cell|
        print cell
      end
      print "\n"
    end
  end

  def congratulate
    print "Congratulations you won!"
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
