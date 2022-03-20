class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_one_attached :profile_image
  
  has_many :relationships, foreign_key: "follow_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "relationships", foreign_key: "follower_id", dependent: :destroy

  has_many :follows, through: "reverse_of_relationships", source: :follower
  has_many :followers, through: "relationships", source: :follow
  
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def follow(user_id)
    relationships.create(follower_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end
  
  def follow?(user)
    followers.include?(user)
  end  
  
end
