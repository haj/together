class HomeControllerTest < ActionController::TestCase

  should "get index" do
    get :index

    assert_response :success
  end
end