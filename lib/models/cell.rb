# frozen_string_literal: true

# Cell class for denoting the properties of the board's square
class Cell
  attr_accessor :neighbor_bombs, :is_open, :is_bomb

  def initialize
    @is_open = false
    @is_bomb = rand < 0.2
    @neighbor_bombs = 0
  end

  def discover
    @is_open = true
  end

  def print_discover
    @is_bomb ? ' * ' : " #{@neighbor_bombs} "
  end

  def to_s
    @is_open ? print_discover : ' X '
  end
end
