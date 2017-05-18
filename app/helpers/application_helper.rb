module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? "active" : ""

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def profile_action_link(link_text, link_path)
    content_tag(:li, :class => "btn btn-default btn-sm tip btn-responsive") do
      link_to link_text, link_path
    end
  end

  def current_user_subscribed?
    user_signed_in? && current_user.subscribed?
  end

  def card_fields_class
    "hidden" if current_user.card_last4?
  end
end
