# frozen_string_literal: true

require 'rubocop/rake_task'

task default: %w[test lint]

task :test do
  ruby 'test/all.rb'
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = true
end
