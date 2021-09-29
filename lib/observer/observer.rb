# frozen_string_literal: true

# observer class for observable update
class Observer
  def update(_board)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end
