class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.boolean :is_done, :default => 0, :null => false
      t.integer :story_id

      t.timestamps
    end
    add_index :tasks, :story_id
  end
end
