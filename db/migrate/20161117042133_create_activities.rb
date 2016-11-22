class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :action
      t.integer :target_id
      t.string :target_type
      t.integer :parent_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
