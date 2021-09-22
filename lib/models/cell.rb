# frozen_string_literal: true

# Cell class for denoting the properties of the board's square
class Cell
  attr_accessor :neighbor_bombs, :is_open, :is_bomb

  def initialize
    @is_open = false
    @is_bomb = rand < 0.14
    @neighbor_bombs = 0
  end
#   def print_cell
    
#   end
end
