module TasksHelper
  def task_status_label(status_id)
    return '<label class="bg-blue-light p-2 rounded-lg text-white">Upcomming</label>' if status_id == "upcomming"
    return '<label class="bg-green-light p-2 rounded-lg text-white">In Progress</label>' if status_id == "in_progress"
    return '<label class="bg-red-light p-2 rounded-lg text-white">Finished</label>' if status_id == "finished"
  end

  def not_assignees(task)
    task.campain.participant_users - task.assignees
  end
end
