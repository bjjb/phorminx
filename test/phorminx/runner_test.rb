require 'test_helper'
require 'phorminx/runner'

describe Phorminx::Runner do
  let(:loader) do
    Phorminx::Loader.new
  end

  let(:analyser) do
    Phorminx::Analyser.new
  end

  let(:formatter) do
    Phorminx::Formatter.new
  end

  let(:runner) do
    Phorminx::Runner.new(loader, analyser, formatter)
  end

  it "runs a loader" do
    runner.run
  end
end
