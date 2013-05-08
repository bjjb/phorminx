require 'test_helper'
require 'phorminx/active_record/inspector'

describe Phorminx::ActiveRecord::Inspector do
  describe "defaults" do
    before do
      @inspector = Phorminx::ActiveRecord::Inspector.new
    end

    it "uses the PWD as the root" do
       @inspector.root.must_equal Pathname.pwd.expand_path
    end

    it "uses an in memory database" do
      @inspector.db['adapter'].must_equal 'sqlite3'
      @inspector.db['database'].must_equal ':memory:'
    end

    it "uses app/models as the models dir" do
      @inspector.model_dirs.must_include @inspector.root.join('app/models')
    end
  end

  describe "in a Rails project" do
    before do
      @inspector = Phorminx::ActiveRecord::Inspector.new(:root => '../../test/rails2')
    end

    it "has its root in the Rails app" do
      @inspector.root.must_equal Pathname.pwd.join('../test/rails2').expand_path
    end

    it "recognises all tables" do
      @inspector.tables.must_include 'products'
    end
  end
end
