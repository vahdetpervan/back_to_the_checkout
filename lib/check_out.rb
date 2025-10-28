class CheckOut
  def initialize(rules)
    @rules = rules
    @items = []
  end

  def total
    @items.tally.inject(0) do |total, (item, quantity)|
      times = quantity / @rules[item]["special_offer"]["quantity"]
      remainder = quantity % @rules[item]["special_offer"]["quantity"]

      total += @rules[item]["special_offer"]["price"] * times
      total += @rules[item]["price"] * remainder
    end
  end

  def scan(item) = @items << item
end
