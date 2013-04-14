class CreateUserStories < ActiveRecord::Migration
  def change
    create_table :user_stories do |t|
      t.integer :user_id
      t.integer :story_id
      t.integer :distance, :default => 0, :null => false
      t.boolean :is_assigned, :default => false, :null => false
      t.timestamps
    end
    add_index :user_stories, :user_id
    add_index :user_stories, :story_id
  end
end
