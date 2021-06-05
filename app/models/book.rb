class Book < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy

  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  #def self.search(search)
    #return Book.all unless search
    #Book.where(['content LIKE ?', "%#{search}%"])
  #end

  def self.looks(searches, words)
    if searches == "perfect_match"
      @book = Book.where("name LIKE ?", "#{words}")
    else
      @book = Book.where("neme LIKE ?", "%#{words}%")
    end
  end

end