require 'test_helper'
require 'phorminx/graph'

describe Phorminx::Graph do
  let(:graph) { Phorminx::Graph.new }

  it "is comprised of nodes and links" do
    graph.nodes.must_be_kind_of Set
    graph.links.must_be_kind_of Set
  end

  it "is enumerable" do
    graph.must_respond_to :each
  end
end
