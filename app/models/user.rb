class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :favorited_book, through: :favorites, source: :user

  has_many :book_comments, dependent: :destroy


  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: { in: 2..20 }
  #validates :email, presence: true

  #validates :email, uniqueness: true

  validates :introduction, length: { maximum: 50}

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy



  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed,source: :follower

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy


  def self.looks(search, words)
    if search == "perfect_match"
      @user = User.where("name LIKE ?", "#{words}")

    elsif search == "front_match"
      @user = User.where("name LIKE ?", "#{words}%")

    elsif search == "back_match"
      @user = User.where("name LIKE ?", "%#{words}")

    elsif search == "partial_match"
      @user = User.where("name LIKE ?", "%#{words}%")
    end
  end

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

end