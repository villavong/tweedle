module ApplicationHelper

def no_email
	User.where("yes_email = ?", true)
end
	def markdownify(content)
	    pipeline_context = { gfm: true, asset_root: "https://a248.e.akamai.net/assets.github.com/images/icons" }
	    pipeline = HTML::Pipeline.new [
	      HTML::Pipeline::MarkdownFilter,
	      HTML::Pipeline::EmojiFilter,
	      HTML::Pipeline::SanitizationFilter,
	    ], pipeline_context
	    pipeline.call(content)[:output].to_s.html_safe
	  end
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

	def active_page(active_page)
		 @active == active_page ? "active" : ""
	end

	def autocomplete

	  @search = User.ransack(params[:q])
	  @user = @search.result.order("created_at DESC").to_a.uniq

	  @results = @search.result
	  @arrUsers = @results.to_a

	end


end
