class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id

    if @book_comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: book_path(@book) }
      end
    else
      # Turbo: フォームだけエラー付きで差し替え
      respond_to do |format|
        format.turbo_stream { render :create, status: :unprocessable_entity }
        format.html do
          # show でエラー表示したいので、必要な変数を揃えて render
          @book_detail = @book
          @book = Book.new
          render "books/show", status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:id])

    unless @book_comment.user == current_user
      return redirect_back fallback_location: book_path(@book), alert: "You are not authorized to do that."
    end

    @book_comment.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: book_path(@book) }
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
