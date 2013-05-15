require 'test_helper'
require 'phorminx'

describe Phorminx do
  describe ActiveRecord do
    it "can export" do
      export = ActiveRecord.export
      export.to_s.must_equal <<-RUBY
class Category < ActiveRecord::Base
has_and_belongs_to_many :products, {:join_table=>"categories_products"}
end

class Product < ActiveRecord::Base
belongs_to :user
has_many :taggings, {:as=>:taggable}
has_many :tags, {:through=>:taggings}
has_and_belongs_to_many :categories, {:join_table=>"categories_products"}
end

class Tag < ActiveRecord::Base
has_many :taggings, {}
has_many :taggables, {:through=>:taggings}
end

class Tagging < ActiveRecord::Base
belongs_to :tag
belongs_to :taggable, {:polymorphic=>true}
end

class User < ActiveRecord::Base
has_many :wares, {:class_name=>"Product"}
end
      RUBY
    end
  end
end
