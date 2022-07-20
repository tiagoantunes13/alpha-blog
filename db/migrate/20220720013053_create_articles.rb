class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :tittle
      t.text :description
      t.timestamps
    end
  end
end
