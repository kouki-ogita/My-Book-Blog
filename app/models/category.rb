class Category < ApplicationRecord
  validates :name, presence: true, length: {maximum: 20}
  
  belongs_to :user
  has_many :posts, dependent: :destroy
end
