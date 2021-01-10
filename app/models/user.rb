class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :profile, length: { maximum: 300 }
  mount_uploader :image, ImageUploader
  
  has_many :posts, dependent: :destroy
  
  #フォロー機能 自分→相手へフォロー#
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  
  #フォロー機能 相手→自分をフォロー#
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  #いいね機能 自分→投稿をいいね#
  has_many :likes, dependent: :destroy
  has_many :favorites, through: :likes, source: :post
  
  def favorite(post)
    self.likes.find_or_create_by(post_id: post.id)
  end 
  
  def unfavorite(post)
    like = self.likes.find_by(post_id: post.id)
    like.destroy if like
  end 
  
  def favoriting?(post)
    self.favorites.include?(post)
  end 
  
  has_many :comments, dependent: :destroy
  has_many :categories, dependent: :destroy
end
