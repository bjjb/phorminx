require 'test_helper'
require 'phorminx/loader'

describe Phorminx::Loader do
  let(:loader) { Phorminx::Loader.new }

  it "knows about Rails" do
    loader.must_respond_to :rails?
    within :rails2 do
      loader.must_be :rails?
      loader.must_be :rails2?
    end
    within :rails3 do
      loader.must_be :rails?
      loader.must_be :rails3?
    end
    within :rails4 do
      loader.must_be :rails?
      loader.must_be :rails4?
    end
  end

  it "loads whatever is in requires" do
    results = []
    block = lambda { results = requires }
    loader = Class.new(Phorminx::Loader) { define_method(:load, &block) }.new
    loader.require 'blah'
    loader.require 'bloo'
    loader.load
    results.must_include 'blah'
    results.must_include 'bloo'
  end

  it "really loads ruby files" do
    tmpfile = Tempfile.open("chucker.rb") { |f| f << "throw :uh_oh" }
    loader = Phorminx::Loader.new
    loader.require tmpfile.path
    lambda { loader.load }.must_throw :uh_oh

    tmpfile = Tempfile.open("printer.rb") { |f| f << "puts 'Hullo, world'" }
    loader = Phorminx::Loader.new
    loader.require tmpfile.path
    lambda { loader.load }.must_output "Hullo, world\n"
  end

  describe "rails 2" do
    it "loads environment.rb" do
      within :rails2 do
        Phorminx::Loader.new.requires.must_include 'config/environment.rb'
      end
    end
  end

  describe "rails 3" do
    it "loads application.rb" do
      within :rails3 do
        Phorminx::Loader.new.requires.must_include 'config/application.rb'
      end
    end
  end

  describe "rails 4" do
    it "loads application.rb" do
      within :rails4 do
        Phorminx::Loader.new.requires.must_include 'config/application.rb'
      end
    end
  end
end
