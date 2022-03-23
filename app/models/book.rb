class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    book_title_body = 'title LIKE ? OR body LIKE ?'
    if method == 'perfect'
      Book.where((:title || :body) => content)
    elsif method == 'forward'
      Book.where(book_title_body, "#{content}%", "#{content}%")
    elsif method == 'backward'
      Book.where(book_title_body, "%#{content}", "%#{content}")
    else
      Book.where(book_title_body, "%#{content}%", "%#{content}%")
    end
  end
end
