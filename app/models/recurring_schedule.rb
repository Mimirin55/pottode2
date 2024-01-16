class RecurringSchedule < ApplicationRecord
  belongs_to :task

  def create_tasks
    schedule = IceCube::Schedule.from_yaml(self.schedule)
      @task = Task.new(
        title: "繰り返しタスク",
        start_date: occurrence_time,
        end_date: occurrence_time + (self.task.end_date - self.task.start_date),
      )
      @task.save!
  end
end
