require 'test_helper'
require 'phorminx/analyser'

describe Phorminx::Analyser do
  let(:analyser) do
    Phorminx::Analyser.new
  end

  it "can analyse its object space and return a tree" do
    person = "bob"
    analyser.analyse([person]).must_be_kind_of Phorminx::Graph
  end
end

