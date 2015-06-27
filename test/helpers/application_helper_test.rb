# encoding: utf-8
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "オーディオPRO", full_title_help
    assert_equal "Help | オーディオPRO", full_title_help("Help")
    assert_equal "ABC | DEF | オーディオPRO", full_title_help("ABC,DEF")
  end
  
  test "test commas help" do
    key = 1
    assert_equal "1", commas_help(key)
    key = 1000
    assert_equal "1,000", commas_help(key)
    key = 1000000
    assert_equal "1,000,000", commas_help(key)
  end
  
  test "test hiffen help" do
    key = 1234
    assert_equal "1234", hiffen_help(key)
    key = 12345
    assert_equal "1-2345", hiffen_help(key)
    key = 123456789
    assert_equal "1-2345-6789", hiffen_help(key)
  end

  # test is_domestic_hash_help
  test "test is domestic hash help" do
    expected = {"0" => "海外", "1" => "国内", "2" => "発送中"}
    assert_equal expected, is_domestic_hash_help
  end

  # test is_domestic_name_help
  test "test is domestic name help" do
    assert_equal "海外", is_domestic_name_help(0)
    assert_equal "国内", is_domestic_name_help(1)
  end
end