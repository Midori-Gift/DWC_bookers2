class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @users = current_user
    @books = @user.books.page(params[:page]).reverse_order
    @book_all = Book.all

  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all

  end

  def edit
    @user = User.find(params[:id])
    ##if current_user == @user.id
    ##render :edit
    ##else
    ##redirect_to books_path
    ##end

  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end


  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
