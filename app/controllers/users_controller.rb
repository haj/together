class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET users.json
  def index
    @users = user_scope

    respond_to do |format|
      format.json { render json: @users }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @user }
    end
  end

  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.json { render json: @user, status: :created, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  # TODO: ids param
  def user_scope
    User.scoped
  end
end