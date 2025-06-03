module ApplicationHelper
  def field_error(resource, field)
    return unless resource.errors[field].any?

    content_tag(:p, resource.errors[field].first, class: "mt-1 text-sm text-red-600")
  end
end
