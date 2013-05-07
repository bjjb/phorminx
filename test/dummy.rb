# A dummy ActiveRecord application, useful for playing around with ActiveRecord,
# or for writing tests. Makes a Sqlite3 database in memory.
#
# Creates the following tables:
#
# - products
# - users
# - taggings
# - tags
# - categories
# - categories_products
#
# and models:
#
# - Product
# - User
# - Tag
# - Tagging
# - Category
# and 3 users (Alice, Bob and Cecil), who have 2 products each, some of which are tagged and categorized.
require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection({ 'adapter' => 'sqlite3', 'database' => ':memory:' })

def create_table(*args, &block)
  ActiveRecord::Base.connection.create_table(*args, &block)
end

ActiveRecord::Base.connection.create_table :users do |t|
  t.string :email
  t.string :name
  t.timestamps
end

ActiveRecord::Base.connection.create_table :products do |t|
  t.string :name
  t.belongs_to :user
  t.timestamps
end
ActiveRecord::Base.connection.add_index :products, :user_id

ActiveRecord::Base.connection.create_table :tags do |t|
  t.string :name
  t.belongs_to :tagging
  t.timestamps
end

ActiveRecord::Base.connection.create_table :taggings do |t|
  t.belongs_to :taggable, :polymorphic => true
  t.belongs_to :tag
end
ActiveRecord::Base.connection.add_index :taggings, [:taggable_type, :taggable_id]
ActiveRecord::Base.connection.add_index :taggings, :tag_id

ActiveRecord::Base.connection.create_table :categories do |t|
  t.string :name
  t.timestamps
end

ActiveRecord::Base.connection.create_table :categories_products, :primary_key => false do |t|
  t.references :category
  t.references :product
end

class Category < ActiveRecord::Base
  has_and_belongs_to_many :products
  attr_accessible :name
end

class Product < ActiveRecord::Base
  belongs_to :user
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
  has_and_belongs_to_many :categories
  attr_accessible :email, :name
end

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :taggables, :through => :taggings
  attr_accessible :name
end

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
  attr_accessible :taggable
end

class User < ActiveRecord::Base
  has_many :wares, :class_name => 'Product'
end

alice = User.create! { |u| u.email, u.name = 'alice@example.com', 'Alice' }
anorak = alice.wares.create! { |p| p.name = 'Anorak' }
armchair = alice.wares.create! { |p| p.name = 'Armchair' }
bob = User.create! { |u| u.email, u.name = 'bob@example.com', 'Bob' }
bun = bob.wares.create! { |p| p.name = 'Bun' }
biscuit = bob.wares.create! { |p| p.name = 'Biscuit' }
cecil = User.create! { |u| u.email, u.name = 'cecil@example.com', 'Cecil' }
crisps = cecil.wares.create! { |p| p.name = 'Crisps' }
chips = cecil.wares.create! { |p| p.name = 'Chips' }
anorak.categories << Category.find_or_create_by_name('Clothes')
armchair.categories << Category.find_or_create_by_name('Furniture')
[bun, biscuit, crisps, chips].each { |x| Category.find_or_create_by_name('Food') }
[bun, biscuit].each { |x| x.tags << Tag.find_or_create_by_name('Baked') }
[crisps, chips].each { |x| x.tags << Tag.find_or_create_by_name('Unhealthy') }
