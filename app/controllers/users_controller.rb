class UsersController < ApplicationController
  protect_from_forgery

  def show
    @users = current_user
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order

    @book_all = Book.all
    @book = @user.books
    @new_book = Book.new

    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomID = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end

  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    @books = Book.all

  end

  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end

  def follow
    @users = User.all
    @user = User.find(params[:id])
  end

  def follower
    @users = User.all
    @user = User.find(params[:id])
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
