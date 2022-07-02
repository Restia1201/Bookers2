class BooksController < ApplicationController
  before_action :move_to_signed_in


  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
    else
     @user = current_user
     @books = Book.all
     render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.new
    @find_book = Book.find(params[:id])
    @user = @find_book.user
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
   @book = Book.find(params[:id])
   if @book.user == current_user
     render :edit
   else
     redirect_to books_path
   end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "You have updated book successfully"
     redirect_to book_path(@book)
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


  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
