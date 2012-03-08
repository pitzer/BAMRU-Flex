
module ApplicationHelper

  # Generates a link for the twitter-bootstrap nav bar, adding an
  # 'active' class if the link points to the current page.
  # This is like 'link_to_unless_current' for twitter-bootstrap.
  def bootstrap_link_to(name, options = {}, html_options = {}, &block)
    class_option = on_current_page?(options) ? " class='active'" : ""
    result = link_to name, options, html_options, &block
    "<li #{class_option}>#{result}</li>"
  end

  private

  # returns True if the input path == the current page
  def on_current_page?(path)
    request.path == path
  end


end
