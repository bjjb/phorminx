require 'test_helper'
require 'phorminx/logging'

describe Phorminx::Logging do
  it "adds a logger method to classes that extend it" do
    klass = Class.new { extend Phorminx::Logging }
    klass.logger.must_be_kind_of Logger
    %w(fatal error warn info debug).each do |ll|
      klass.must_respond_to :"#{ll}"
    end
  end
end
