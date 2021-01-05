class Comment < ApplicationRecord
  validates :remark, presence: true, length: {maximum: 1000}
  
  belongs_to :user
  belongs_to :post
end 
