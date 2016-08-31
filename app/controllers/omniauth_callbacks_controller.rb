class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])

		if @user.persisted?
			sign_in_and_redirect @user, :event => :authentication

			respond_to do |format|
				format.html { redirect_to edit_user_registration, notice: '프로필을 수정해 주세요 :)' }
				format.json { head :no_content }
			end
			# set_flash_message(:notice, :success, :kind => "Facebook. 프로필을 수정하세요!") if is_navigational_format?


		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url

		end
	end
end
