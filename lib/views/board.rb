# frozen_string_literal: true
require  'matrix'
require_relative '../observer/observer'

class BoardView < Observer

  def update(boardModel)
    clean()
    printBoard(boardModel)
  end

  def printBoard(boardModel)
    print "   "
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

  def congratulate(playerSymbol)
    #TODO
  end

  def gameOver()
    #TODO
  end

  def clean
    # TODO
  end

  def printOptions
    print "Select position (x,y)\n"
  end

end
