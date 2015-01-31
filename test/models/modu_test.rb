require 'test_helper'

class ModuTest < ActiveSupport::TestCase
  def setup
    @brand = brands(:one)
    @modu = @brand.modus.build(modu_name: 'Modu Name 001001')
  end

  # test @modu
  test "should be valid" do
    assert @modu.valid?
  end

  # test field modu_id
  test "modu_id should be allow blank" do
    @modu.modu_id = "    "
    assert @modu.valid?
  end

  test "modu_id should not be too long" do
    @modu.modu_id = "a" * 8
    assert_not @modu.valid?
  end

  test "modu_id should be unique" do
    @modu.modu_id = 'testtes'
    duplicate_modu = @modu.dup
    duplicate_modu.modu_id = @modu.modu_id.upcase
    @modu.save
    assert_not duplicate_modu.valid?
  end

  # test field modu_name
  test "modu_name should be presence" do
    @modu.modu_name = "    "
    assert_not @modu.valid?
  end

  test "modu_name should not be too long" do
    @modu.modu_name = "a" * 101
    assert_not @modu.valid?
  end

  # test field brand_id
  test "brand_id should be present" do
    @modu.brand_id = nil
    assert_not @modu.valid?
  end

  test "brand_id should not be too long" do
    @modu.brand_id = "a" * 5
    assert_not @modu.valid?
  end

  # test ORDER BY
  test "order should be miximum ID first" do
    assert_equal Modu.first, modus(:one)
  end

  # test as_hash
  test "should get data as hash" do
    @modu.modu_id = 'TEST'
    expected = {'TEST' => 'Modu Name 001001'}
    assert_equal expected, @modu.as_hash
  end

  # test as_json
  test "should get data as json include modu_id and modu_name" do
    @modu.modu_id = 'TEST'
    expected = {'modu_id' => 'TEST', 'modu_name' => 'Modu Name 001001'}
    assert_equal expected, @modu.as_json
  end

  # test before_create
  test "should auto generate modu id when id not presence" do
    @modu.save
    @modu.reload
    assert_not_nil @modu.modu_id
  end
end
