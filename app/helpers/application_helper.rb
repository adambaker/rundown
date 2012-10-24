module ApplicationHelper
  def show_price(price)
    sprintf '%0.2f', price
  end
end
