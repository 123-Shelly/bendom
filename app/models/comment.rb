class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :content, presence: true
  default_scope { order(id: :desc) }
  # order(id: :desc) 讓他正向排列
end
