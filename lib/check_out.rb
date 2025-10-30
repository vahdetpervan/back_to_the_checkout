class CheckOut
  def initialize(rules)
    @rules = rules
    @items = []
  end

  def total
    @items.tally.sum do |item, quantity|
      product_obj = @rules[item].new
      offer_rules = product_obj.special_offer_rules
      quotient, modulus = offer_rules[:quantity].zero? ? [0, quantity] : quantity.divmod(offer_rules[:quantity])
      (offer_rules[:price] * quotient) + (product_obj.unit_price * modulus)
    end
  end

  def scan(item) = @items << item
end
