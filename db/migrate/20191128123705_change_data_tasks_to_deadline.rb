class ChangeDataTasksToDeadline < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :deadline, :string
  end
end
