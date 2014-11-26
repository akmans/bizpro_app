require 'test_helper'

class ModuTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @brand = brands(:one)
    @modu = @brand.modus.build(modu_id: 'M001001', modu_name: 'Modu Name 001001')
  end

  test "should be valid" do
    assert @modu.valid?
  end
  
  test "modu_id should be presence" do
    @modu.modu_id = "    "
    assert_not @modu.valid?
  end
  
  test "modu_id should not be too long" do
    @modu.modu_id = "a" * 8
    assert_not @modu.valid?
  end
  
  test "modu_id should be unique" do
    duplicate_modu = @modu.dup
    duplicate_modu.modu_id = @modu.modu_id.upcase
    @modu.save
    assert_not duplicate_modu.valid?
  end
  
  test "modu_name should be presence" do
    @modu.modu_name = "    "
    assert_not @modu.valid?
  end
  
  test "modu_name should not be too long" do
    @modu.modu_name = "a" * 101
    assert_not @modu.valid?
  end

  test "brand_id should be present" do
    @modu.brand_id = nil
    assert_not @modu.valid?
  end
  
  test "brand_id should not be too long" do
    @modu.brand_id = "a" * 5
    assert_not @modu.valid?
  end
  
  test "order should be miximum ID first" do
    assert_equal Modu.first, modus(:modu_M101101)
  end
end
