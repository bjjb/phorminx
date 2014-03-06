require 'bundler'
require 'minitest/autorun'
require 'fileutils'

module Workspace
  def self.extended(mod)
    mod.send(:include, self)
  end

  def workspace
    @@workspace ||= 'tmp/dummy'
  end

  def within(branch)
    branch = branch.to_s
    old = Dir.pwd
    Dir.chdir(workspace)
    system "git checkout -q #{branch}"
    system "git reset -q --hard HEAD"
    result = yield
    system "git checkout -q master"
    Dir.chdir(old)
    result
  end

  def setup
    unless File.directory?(workspace)
      FileUtils.mkdir_p workspace
      system "git clone git://github.com/bjjb/dummy-webapps.git '#{workspace}'"
    end
  end
end

puts MiniTest::Test.extend Workspace
