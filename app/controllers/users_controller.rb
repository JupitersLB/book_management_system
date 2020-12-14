class UsersController < ApplicationController
  def show
    @user = User.where(id: params[:id]).includes(:books).first
    not_found unless @user
  end

  def create
    @user = User.new(user_params)
    @user.account_number = 'JLB' + 7.times.map { rand(0..9) }.join
    @user.email = "#{@user.account_number}@ekohe.com"
    @user.password = 'password'
    if @user.save
      render :show
    else
      render_error
    end
  end

  private

  def user_params
    params.require(:user).permit(:balance)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
           status: :unprocessable_entity
  end

  def not_found
    render json: { errors: "Can't find User" },
           status: 404
  end
end
