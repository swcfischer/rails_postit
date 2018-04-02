module ApplicationHelper

  def http_fix(url)
    url.starts_with?("http") ? url : "http://#{url}"
  end

  def date_fix(date_input)
    date_input.strftime("%m/%d/%Y %l:%M %Z") if date_input
  end
end
