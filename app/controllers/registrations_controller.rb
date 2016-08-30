class RegistrationsController < Devise::RegistrationsController
	skip_before_action :autocomplete




	protected
		def update_resource(resource, params)
			resource.update_without_password(params)
		end

    def after_update_path_for(resource)
      user_path(resource)
    end
		def after_sign_up_path_for(resource)
	    edit_user_registration_path
	  end
		def after_sign_in_path_for(resource)
	    request.env['omniauth.origin'] || stored_location_for(resource) || edit_user_registration_path
	  end
end
