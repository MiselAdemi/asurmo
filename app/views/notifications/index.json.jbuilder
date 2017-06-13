json.array! @notifications do |notification| 
    json.recipient notification.recipient 
    json.action notification.action 
    json.notifiable notification.notifiable
    json.read notification.read
end 