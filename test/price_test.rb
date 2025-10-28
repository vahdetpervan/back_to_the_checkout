require 'minitest/autorun'
require_relative '../lib/check_out'

class TestPrice < Minitest::Test
  RULES = {
    "A" => { "unit_price" => 50, "special_offer" => { "quantity" => 3, "price" => 130 } },
    "B" => { "unit_price" => 30, "special_offer" => { "quantity" => 2, "price" => 45 } },
    "C" => { "unit_price" => 20, "special_offer" => { "quantity" => 1, "price" => 20 } },
    "D" => { "unit_price" => 15, "special_offer" => { "quantity" => 1, "price" => 15  } }
  }

  def price(goods)
    co = ::CheckOut.new(RULES)
    goods.split(//).each { |item| co.scan(item) }
    co.total
  end

  def test_totals
    assert_equal(  0, price(""))
    assert_equal( 50, price("A"))
    assert_equal( 80, price("AB"))
    assert_equal(115, price("CDBA"))

    assert_equal(100, price("AA"))
    assert_equal(130, price("AAA"))
    assert_equal(180, price("AAAA"))
    assert_equal(230, price("AAAAA"))
    assert_equal(260, price("AAAAAA"))

    assert_equal(160, price("AAAB"))
    assert_equal(175, price("AAABB"))
    assert_equal(190, price("AAABBD"))
    assert_equal(190, price("DABABA"))
  end

  def test_incremental
    co = ::CheckOut.new(RULES)
    assert_equal(0, co.total)
    co.scan("A");  assert_equal( 50, co.total)
    co.scan("B");  assert_equal( 80, co.total)
    co.scan("A");  assert_equal(130, co.total)
    co.scan("A");  assert_equal(160, co.total)
    co.scan("B");  assert_equal(175, co.total)
  end
end
