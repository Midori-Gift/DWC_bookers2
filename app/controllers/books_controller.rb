class BooksController < ApplicationController

  before_action :check_user,{only: [:edit]}


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
      @all_ranks = @books.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
      render :index
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    #@all_ranks = @books.find(Favorite.group(:book_id).order('count() desc').pluck(:book_id))
    @all_ranks = @books.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end



  def search
    if params[:title].present?
      @books = Book.where('title LIKE ?', "%#{params[:title]}%")
    else
      @books = Book.none
    end
  end

  def show
    @books = Book.all
    @book = Book.find(params[:id])
    @new_book = Book.new
    @user = @book.user
    @users = current_user
    @book_comment = BookComment.new

  end

  def edit
    @book = Book.find(params[:id])

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      #flash[:alert] = "asd"
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

  def check_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

end