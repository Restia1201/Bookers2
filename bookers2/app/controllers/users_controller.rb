class UsersController < ApplicationController
  before_action :move_to_signed_in

  def index
    @users = User.all
    @book = Book.new
    @user = current_user

  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
   @user = User.find(params[:id])
    unless
      current_user == @user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private


  def move_to_signed_in
    unless user_signed_in?
      redirect_to '/users/sign_in'
    end
  end


  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


end
