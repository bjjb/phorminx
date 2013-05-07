require 'test_helper'
require 'phorminx'

describe Phorminx do
  it "is part of ActiveRecord::Base" do
    Product.must_be_kind_of Phorminx::ActiveRecord
  end

  it "can make the class return an inspector" do
    Product.inspector.must_be_kind_of Phorminx::ActiveRecordInspector
  end
end
