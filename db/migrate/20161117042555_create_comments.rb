class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :parent_id
      t.integer :target_id
      t.string :target_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
