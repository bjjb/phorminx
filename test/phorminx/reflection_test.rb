require 'test_helper'
require 'phorminx/reflection'

describe Phorminx::Reflection do
  before do
    Class.new do
      include Phorminx::Reflection
    end
  end
end
