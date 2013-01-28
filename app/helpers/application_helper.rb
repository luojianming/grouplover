module ApplicationHelper
  def safe_image_tag(source, options = {})
    if source == nil || source.size == 0
      source = "pic1.jpg"
    end
    image_tag(source, options)
  end
end
