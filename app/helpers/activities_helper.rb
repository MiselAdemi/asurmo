module ActivitiesHelper

  def find_to_whom(id, model)
    if model == "user"
      User.find(id).full_name
    elsif model == "organization"
      Organization.find(id).name
    elsif model == "campain"
      Campain.find(id).name
    elsif model == "event"
      Event.find(id).name
    end
  end

  def find_to_whom_path(id, model)
    if model == "user"
      user_path(id)
    elsif model == "organization"
      organization_path(id)
    elsif model == "campain"
      campain = Campain.find(id)
      organization_campain_path(campain.organization, id)
    elsif model == "event"
      event = Event.find(id)
      organization_campain_event_path(event.campain.organization, event.campain, id)
    end
  end
end
