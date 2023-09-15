class Category < ApplicationRecord
  #=================== Associations ==================
  has_many :products, dependent: :destroy

  # ==================== Validations ==================
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 200 }
end
