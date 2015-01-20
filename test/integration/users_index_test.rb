# encoding: utf-8
require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  test "index including pagination and delete links" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1, per_page: 15)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: '表示'
      assert_select 'a[href=?]', user_path(user), text: '削除', method: :delete
    end
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end
end
