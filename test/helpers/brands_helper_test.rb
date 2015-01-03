# encoding: utf-8
require 'test_helper'

class BrandsHelperTest < ActionView::TestCase
  def setup
    @brand = brands(:one)
  end

  test "test brand name help" do
    assert_equal "-", brand_name_help(nil)
    assert_equal "-", brand_name_help("    ")
    assert_equal @brand.brand_name, brand_name_help(@brand.brand_id)
  end
  
  test "test brand hash help" do
    assert_not_nil brand_hash_help
  end
end