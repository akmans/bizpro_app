require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
    @other_user = users(:two)
  end

  # test index action
  test "should get index when logged in" do
    log_in_as(@user)
    get :index
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1, per_page: 15)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: 'Dis'
      assert_select 'a[href=?]', edit_user_path(user), text: 'Edi'
      assert_select 'a[href=?]', user_path(user), text: 'Del', method: :delete
    end
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  # test show action
  test "should get show when logged in" do
    log_in_as(@user)
    get :show, id: @user
    assert_response :success
    assert_select 'title', full_title_help('表示,ユーザー,マスタ管理')
    assert_not_nil assigns(:user)
  end

  test "should redirect show when not logged in" do
    get :show, id: @user
    assert_redirected_to login_url
  end

  # test new action
  test "should get new" do
    get :new
    assert_response :success
  end

  # test create action
  # nil

  # test edit action
  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  # test update action
  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # test destroy action
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete :destroy, id: @user
    end
    assert_redirected_to login_url
  end
end
