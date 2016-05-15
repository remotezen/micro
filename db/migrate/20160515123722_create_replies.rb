class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :reply
      t.references :micropost, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
      add_index :replies, [:micropost_id, :created_at]
      add_index :replies, [:user_id, :created_at]
  end
end
