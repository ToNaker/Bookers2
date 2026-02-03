class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    current_user.favorites.find_or_create_by(book_id: @book.id)
    redirect_back fallback_location: book_path(@book)
  end

  def destroy
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite&.destroy
    redirect_back fallback_location: book_path(@book)
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
