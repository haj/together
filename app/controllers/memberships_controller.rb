class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :update, :destroy]

  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)

    respond_to do |format|
      if @membership.save
        format.json { render json: @membership, status: :created, location: @membership }
      else
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.json { head :no_content }
      else
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1.json
  def destroy
    @membership.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:user_id, :group_id)
  end

end