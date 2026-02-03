class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id

    if comment.save
      redirect_back fallback_location: book_path(@book)
    else
      # show でエラー表示したいので、必要な変数を揃えて render
      @book_detail = @book
      @book = Book.new
      @book_comment = comment
      render "books/show", status: :unprocessable_entity
    end
  end

  def destroy
    comment = BookComment.find(params[:id])

    unless comment.user == current_user
      return redirect_back fallback_location: book_path(@book), alert: "You are not authorized to do that."
    end

    comment.destroy
    redirect_back fallback_location: book_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
