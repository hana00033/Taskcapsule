class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :deadline, null: false
      t.string :task, null: false
      t.timestamps
    end
  end
end
