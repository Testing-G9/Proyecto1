# frozen_string_literal: true

# Runs all files ending with _test
Dir["#{File.dirname(File.absolute_path(__FILE__))}/**/*_test.rb"].sort.each { |file| require file }
