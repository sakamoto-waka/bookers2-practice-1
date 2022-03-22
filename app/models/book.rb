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
    # 後で変数作ってみる
    if method == 'perfect'
      Book.where((:title || :body) => content)
    elsif method == 'forward'
      Book.where('title LIKE ? OR body LIKE ?', content + '%', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ? OR body LIKE ?', '%' + content, '%' + content)
    else
      Book.where('title LIKE ? OR body LIKE ?', '%' + content + '%', '%' + content + '%')
    end
  end
end
