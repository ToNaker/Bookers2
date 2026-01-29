class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]
  before_action :ensure_correct_user, only: [ :edit, :update, :destroy ]

  def index
    @book  = Book.new
    @books = Book.all
    @user  = current_user   # ←追記（これが無いと @user が nil）
  end


  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to @book, notice: "You have created book successfully."
    else
      @books = Book.all
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @book_detail = @book        # 詳細表示用
    @book = Book.new            # 左フォーム用（New book）
  end



def edit
  @book = Book.find(params[:id])
end


  def update
    if @book.update(book_params)
      redirect_to @book, notice: "You have updated book successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "You have destroyed book successfully."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def ensure_correct_user
    redirect_to books_path, alert: "You are not authorized to do that." unless @book.user == current_user
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
