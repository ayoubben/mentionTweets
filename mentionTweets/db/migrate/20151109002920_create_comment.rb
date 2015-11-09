class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :mention_id
      t.text :text

      t.timestamps null: false
    end
  end
end
