# frozen_string_literal: true

class Observable
  def initialize
    @observers = []
  end

  def addObserver(observer)
    @observers << observer
  end

  def notifyAll
    @observers.each { |observer| observer.update(self) }
  end
end
