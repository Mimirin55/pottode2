class AddRecurrenceToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :recurrence, :string
  end
end
