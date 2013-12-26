class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :description
      t.references :category, index: true

      t.timestamps
    end
  end
end
