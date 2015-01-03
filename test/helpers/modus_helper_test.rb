# encoding: utf-8
require 'test_helper'

class ModusHelperTest < ActionView::TestCase
  def setup
    @modu = modus(:one)
  end

  test "test modu name help" do
    assert_equal "-", modu_name_help(nil)
    assert_equal "-", modu_name_help("    ")
    assert_equal @modu.modu_name, modu_name_help(@modu.modu_id)
  end
end