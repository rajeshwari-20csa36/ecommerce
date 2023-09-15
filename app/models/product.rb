class Product < ApplicationRecord
  self.per_page = 10
  # ============== Associations ===========
  belongs_to :category
  belongs_to :user
  has_many :variants, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :comments
  has_and_belongs_to_many :users, join_table: 'users_products_read_status'

  # ==================== Validations ==================
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { maximum: 200 }

  # ==================== Scopes =======================
  scope :date_between, lambda { |from_date, to_date|
    where('created_at >= ? AND created_at <= ?', from_date, to_date)
  }
end
