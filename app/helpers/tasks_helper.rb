module TasksHelper
  def task_status_label(status_id)
    return '<label class="bg-blue-light p-2 rounded-lg text-white">Upcomming</label>' if status_id == "upcomming"
    return '<label class="bg-yellow-dark p-2 rounded-lg text-white">In Progress</label>' if status_id == "in_progress"
    return '<label class="bg-green-light p-2 rounded-lg text-white">Finished</label>' if status_id == "finished"
    return '<label class="bg-red-light p-2 rounded-lg text-white">Delay</label>' if status_id == "delay"
  end

  def not_assignees(task)
    return task.campain.participant_users - task.assignees if task.campain.participant_users.present?
    return task.campain.organization.users if !task.campain.participant_users.present?
  end

  def task_chart_data(campaign)
    campaign.tasks.group(:status).count
  end

  def task_chart_colors(campaign)
    data = campaign.tasks.group(:status).count
    score_colors = {"upcomming" => 'blue', "in_progress" => 'green', "finished" => 'red'}
    colors = []
    data.each do |score, _|
      colors << score_colors[score]
    end
    colors
  end
end
