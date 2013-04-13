class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :description
      t.boolean :is_done
      t.integer :position, :default => 0, :null => false
      t.integer :user_id
      t.integer :estimate

      t.timestamps
    end
    add_index :stories, :user_id
  end
end