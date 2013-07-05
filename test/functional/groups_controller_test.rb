require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  context "with user" do
    setup do
      @user = create(:user)
      @user.create_tenant
      sign_in @user
    end

    should "create group" do
      post :create, group: {name: 'test'}, format: :json

      assert_response :success
      @user.with_tenant_scope_schema do
        assert_equal 1, Group.count
      end
    end

    context "with group" do
      setup do
        @group = nil
        @user.with_tenant_scope_schema do
          @group = create(:group, name: 'testgroup')
        end
      end

      should "find groups" do
        Tenant.with_root_tenant_schema do
          create(:group)
        end

        create(:user).with_tenant_scope_schema do
          create(:group)
        end

        get :index, format: :json

        response = JSON.parse(@response.body)
        assert_equal 1, response.count
        assert_equal @group.id, response.first["id"]
      end

      should "show" do
        get :show, id: @group.id, format: :json

        assert_response :success
      end

      should "update" do
        put :update, id: @group.id, group: {name: 'test2'}, format: :json

        assert_response :success
      end

      should "destroy" do
        delete :destroy, id: @group.id, format: :json

        assert_response :success
      end
    end
  end
end