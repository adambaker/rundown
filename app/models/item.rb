class Item
  include Mongoid::Document
  field :name, type: String
  field :price, type: Integer
  field :quantity, type: Integer

  validates :name, presence: true
  validates :quantity, numericality: {
    only_integer: true, greater_than_or_equal_to: 0
  }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def price=(price_str)
    self.write_attribute(:price, price_to_int(price_str))
  end

  def price
    price_int = self.read_attribute(:price) or return ''
    price_str = price_int.to_s
    if price_int < 10
      price_str.insert(0, '0.0')
    else
      price_str.insert(-3, '.')
    end
  end

  private
    def price_to_int(price_str)
      begin
        price_int = (Float(price_str.strip.gsub(/\$|\,/,''))*100).round
      rescue Exception => e
        price_int = ''
      end
    end

    def initialize(attrs={}, opts=nil)
      attrs[:quantity] ||= 1
      super(attrs, opts)
    end
end
