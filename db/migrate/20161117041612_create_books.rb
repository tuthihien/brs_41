class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.date :publish_date
      t.string :author
      t.integer :num_of_page
      t.string :image
      t.float :rating
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
