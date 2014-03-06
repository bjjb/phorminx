require 'bundler/setup'
require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
end
task :test => %w(test/workspaces/rails2 test/workspaces/rails3 test/workspaces/rails4)
task :default => :test
