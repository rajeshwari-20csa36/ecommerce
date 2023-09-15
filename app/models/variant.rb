class Variant < ApplicationRecord
  #====================== Associations ===================
  belongs_to :product, counter_cache: true

  #===================== Validations =========================
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true
end
