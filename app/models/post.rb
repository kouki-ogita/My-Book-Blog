class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 3000 }

  belongs_to :user

end
