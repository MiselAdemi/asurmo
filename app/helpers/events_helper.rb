module EventsHelper
  def event_avatar(event)
		event.avatar.present?? event.avatar.url : 'avatar.jpg'
	end
end
