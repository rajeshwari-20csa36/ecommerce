class Comment < ApplicationRecord
  #================== Associations ====================
  belongs_to :product
  validates :description, presence: true
end
