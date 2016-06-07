module ApplicationHelper

	def alert_for(flash_type)  
  { success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-warning',
    notice: 'alert-info'
  }[flash_type.to_sym] || flash_type.to_s
end  

#our form fo previewing an image in _form.html.erb in posts and edit.html.erb

def form_image_select(post)  
  return image_tag post.image.url,
                   id: 'image-preview',
                   class: 'img-responsive'
                   

end
	
end
