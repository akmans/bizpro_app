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
  
  test "test page ix help" do
    page = 2
    assert_nil session[:page_ix]
    assert_equal page, page_ix_help(page)
    assert_equal page, session[:page_ix]
    assert_equal 1, page_ix_help(session[:page_ix] = nil)
  end
end