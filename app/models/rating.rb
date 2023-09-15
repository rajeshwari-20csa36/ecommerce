class Rating < ApplicationRecord
  #============ Associations ===============
  belongs_to :product, counter_cache: true

  #============= Validations ===============
  validates :star, presence: true

  #============= Callbacks =================
  after_create_commit :cache_rating_average

  #============= Instance Methods ==========
  def cache_rating_average
    product.update_columns(ratings_average: product.ratings.average(:star))
  end

end
