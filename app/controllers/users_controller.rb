class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @book  = Book.new
  end

  def show
    @user  = User.find(params[:id])
    @book  = Book.new
    @books = @user.books
  end

  # ===== followings / followers（追記）=====
  def followings
    @user  = User.find(params[:id])
    @users = @user.followings
    @book  = Book.new
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    @book  = Book.new
  end
  # =======================================

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user), alert: "You are not authorized to do that." unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
