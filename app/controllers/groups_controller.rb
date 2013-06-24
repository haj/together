# TODO: move to together platform
class GroupsController < ApplicationController
  # User groups
  def index
    @groups = current_user.groups

    respond_to do |format|
      format.json { render json: @groups }
    end
  end

  def show
    @group  = current_user.groups.find(params[:id])

    respond_to do |format|
      format.json { render json: @group }
    end
  end
end