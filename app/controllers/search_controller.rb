class SearchController < ApplicationController

  def search
    @books = Book.search(params[:search])
  end

end
