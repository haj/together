require 'test_helper'

class AppControllerTest < ActionController::TestCase
  should "get index and create tenant when signed in" do
    user = create(:user)
    sign_in user

    get :index

    assert_response :success
    assert_equal 1, Tenant.count
  end
end