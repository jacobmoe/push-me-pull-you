class CreatePushes < ActiveRecord::Migration
  def change
    create_table :pushes do |t|
      t.integer :user_id
      t.integer :pushed_user_id
      t.integer :story_id

      t.timestamps
    end
    add_index :pushes, :user_id
    add_index :pushes, :pushed_user_id
    add_index :pushes, :story_id
  end
end
