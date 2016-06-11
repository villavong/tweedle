class RegistrationsController < Devise::RegistrationsController
	skip_before_action :autocomplete

	protected
		def update_resource(resource, params)
			resource.update_without_password(params)
		end

    def after_update_path_for(resource)
      user_path(resource)
    end
end
