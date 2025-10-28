class CheckOut
  def initialize(rules)
    @rules = rules
    @items = []
  end

  def total
    total = 0
    @items.tally.each do |item, quantity|
      times = quantity / @rules[item]["special_offer"]["quantity"]
      remainder = quantity % @rules[item]["special_offer"]["quantity"]

      total += @rules[item]["special_offer"]["price"] * times
      total += @rules[item]["price"] * remainder
    end
    total
  end

  def scan(item) = @items << item
end
