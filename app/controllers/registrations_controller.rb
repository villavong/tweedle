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
		    if resource.sign_in_count == 1
					edit_user_registration_path
					flash[:success] = '프로필을 수정해주세요!'

		    else
		       root_path
		    end
		end

end
