module TasksHelper
  def task_status_label(status_id)
    return '<label class="bg-blue-light p-2 rounded-lg text-white">Upcomming</label>' if status_id == "upcomming"
    return '<label class="bg-green-light p-2 rounded-lg text-white">In Progress</label>' if status_id == "in_progress"
    return '<label class="bg-red-light p-2 rounded-lg text-white">Finished</label>' if status_id == "finished"
  end

  def not_assignees(task)
    task.campain.participant_users - task.assignees
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
