module ApplicationHelper
  def safe_image_tag(source, options = {})
    source ||= "pic1.jpg"
    image_tag(source, options)
  end
end
