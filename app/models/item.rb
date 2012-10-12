class Item
  include Mongoid::Document
  field :name, type: String
  field :price, type: Integer
  field :quantity, type: Integer
end
