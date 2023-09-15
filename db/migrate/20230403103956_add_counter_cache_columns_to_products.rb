class AddCounterCacheColumnsToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :variants_count, :integer, default: 0
    add_column :products, :ratings_count, :integer, default: 0
    add_column :products, :ratings_average, :float, default: 0
  end
end
