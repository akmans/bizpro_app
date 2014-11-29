# encoding: utf-8
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "オーディオPRO"
    assert_equal full_title("Help"), "Help | オーディオPRO"
  end
end