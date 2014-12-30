# encoding: utf-8
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "オーディオPRO", full_title
    assert_equal "Help | オーディオPRO", full_title("Help")
    assert_equal "ABC | DEF | オーディオPRO", full_title("ABC,DEF")
  end
end