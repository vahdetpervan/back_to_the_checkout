class CheckOut
  def initialize(rules)
    @rules = rules
    @items = []
  end

  def total
    @items.tally.sum do |item, quantity|
      product_obj = @rules[item]
      next product_obj.unit_price * quantity unless product_obj.special_offer_available?

      offer_rules = product_obj.special_offer_rules
      times, remainder = quantity.divmod(offer_rules[:quantity])
      (offer_rules[:price] * times) + (product_obj.unit_price * remainder)
    end
  end

  def scan(item) = @items << item
end
