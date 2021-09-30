# frozen_string_literal: true

require 'rubocop/rake_task'
require 'rake/testtask'

task default: %w[test lint]

# task :test do
#   ruby 'test/all.rb'
# end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*test.rb']
  t.verbose = true
end

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = true
end
