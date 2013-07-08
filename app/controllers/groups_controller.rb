class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :update, :destroy]

  # GET groups.json
  #   scope=(my_groups|other_groups)
  #   ids=<ids>
  def index
    @groups = group_scope

    respond_to do |format|
      format.json { render json: @groups }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @group }
    end
  end

  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        format.json { render json: @group, status: :created, location: @group }
      else
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.json { head :no_content }
      else
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end

  # TODO: ids param
  def group_scope
    if params[:scope] && %w(my_groups other_groups).include?(params[:scope])
      Group.send(params[:scope], current_user)
    else
      Group.scoped
    end
  end
end