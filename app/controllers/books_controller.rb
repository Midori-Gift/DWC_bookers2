class BooksController < ApplicationController

  def new
    @user = current_user
    @book = Book.new

  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all

  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @new_book = Book.new


  end

  def edit
    @book = Book.find(params[:id])
    #if @user == current_user
    #render edit
    #else
    #redirect_to books_path
    #end

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      flash[:alert]
      render :edit
    end

  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path

  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end