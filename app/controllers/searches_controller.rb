class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model  = params[:model]
    @method = params[:method]
    @word   = params[:word]

    @records =
      case @model
      when "user"
        User.search_for(@word, @method)
      when "book"
        Book.search_for(@word, @method)
      else
        []
      end
  end
end
