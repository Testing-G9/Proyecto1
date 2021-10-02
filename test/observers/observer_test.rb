# frozen_string_literal: true

require_relative '../test_helper'
require_relative '../../lib/observer/observer'
require 'test/unit'

class ObserverTest < Test::Unit::TestCase
  def setup
    @observer = Observer.new
  end

  def test_raise_not_implemented_error
    assert_raise(NotImplementedError.new("Observer has not implemented method 'update'")) { @observer.update(1) }
  end
end
