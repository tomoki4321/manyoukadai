class ChangeColumnNullTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :task_name, :string, null: false
    change_column :tasks, :task_content, :string, null: false
  end
end
