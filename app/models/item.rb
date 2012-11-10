class Item
  include Mongoid::Document
  field :name, type: String
  field :price, type: Float
  field :quantity, type: Integer
  field :notes, type: String

  embeds_one :public
  accepts_nested_attributes_for :public

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }

  private
    def price_to_float(price_str)
      begin
        price = (Float( price_str.strip.gsub(/\$|\,/,'') )).round(2)
      rescue Exception => e
        price_int = ''
      end
    end

    def initialize(attrs={}, opts=nil)
      attrs[:quantity] ||= 1
      attrs[:price] = price_to_float(attrs[:price])
      super(attrs, opts)
      self.public or self.build_public
      self
    end
end

class Public
  include Mongoid::Document
  field :title
  field :body

  embedded_in :item
end
