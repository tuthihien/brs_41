class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :cate_name
      t.string :title
      t.date :publish_date
      t.string :author
      t.integer :num_of_page
      t.string :image
      t.boolean :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
