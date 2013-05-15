require 'test_helper'
require 'phorminx'

describe Phorminx do
  describe ActiveRecord do
    it "can export" do
      export = ActiveRecord.export
      export.to_s.must_equal <<-RUBY
# Generated using phorminx v#{Phorminx::VERSION}

class Admin < User
  self.table_name = 'users'
  
  has_many :wares, {:class_name=>"Product"}
  
end

class Category < ActiveRecord::Base
  self.table_name = 'categories'
  
  has_and_belongs_to_many :products, {:join_table=>"categories_products"}
  
end

class Product < ActiveRecord::Base
  self.table_name = 'products'
  
  belongs_to :user
  
  has_many :taggings, {:as=>:taggable}
  
  has_many :tags, {:through=>:taggings}
  
  has_and_belongs_to_many :categories, {:join_table=>"categories_products"}
  
end

class Tag < ActiveRecord::Base
  self.table_name = 'tags'
  
  has_many :taggings
  
  has_many :taggables, {:through=>:taggings}
  
end

class Tagging < ActiveRecord::Base
  self.table_name = 'taggings'
  
  belongs_to :tag
  
  belongs_to :taggable, {:polymorphic=>true}
  
end

class User < ActiveRecord::Base
  self.table_name = 'users'
  
  has_many :wares, {:class_name=>"Product"}
  
end

      RUBY
    end
  end
end
