class History < ApplicationRecord
  # belongs_to :event
  
  belongs_to :user
  belongs_to :event
end
