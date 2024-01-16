class CreateRecurringSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :recurring_schedules do |t|
      t.references :task, null: false, foreign_key: true
      t.text :schedule, null: false

      t.timestamps
    end
  end
end
