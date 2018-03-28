class NotificationMailer < ApplicationMailer
  def task_comment_notification(user, task)
    @user = user
    @task = task

    mail(
      to: "#{user.email}",
      subject: "[Asurmo] New comment in #{task.name} task"
    )
  end
end
