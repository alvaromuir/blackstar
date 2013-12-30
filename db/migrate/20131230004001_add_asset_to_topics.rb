class AddAssetToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :asset, :string
  end
end
