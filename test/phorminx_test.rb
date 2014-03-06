require 'test_helper'
require 'phorminx'
require 'pathname'

describe Phorminx do
  it "is totally rad" do
    Phorminx::VERSION.wont_be_nil
  end

  it "has an executable" do
    exe = Pathname.new(__FILE__).join('../../bin/phorminx')
    exe.must_be :executable?
    exe.read(2).must_equal '#!'
  end

  it "has a CLI" do
    Phorminx::CLI
  end

  it "has a logger" do
    Phorminx.logger.must_be_kind_of Logger
  end

  it "is bundled as a beautiful gem" do
    gemspec = Pathname.new(__FILE__).join("../../phorminx.gemspec")
    gemspec.must_be :readable?
    load gemspec.expand_path # shouldn't explode
  end

  it "can tell which environment its running in" do
    within :rails2 do
      Phorminx.must_be :rails?
      Phorminx.must_be :rails2?
    end
    within :rails3 do
      Phorminx.must_be :rails?
      Phorminx.must_be :rails3?
    end
    within :rails4 do
      Phorminx.must_be :rails?
      Phorminx.must_be :rails4?
    end
  end
end
