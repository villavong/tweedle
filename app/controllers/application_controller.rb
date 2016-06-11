class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

before_action  :configure_permitted_parameters, if: :devise_controller?

helper_method :mailbox
before_filter :autocomplete

private

def mailbox
    @mailbox ||= current_user.mailbox
end

def autocomplete

  @search = User.ransack(params[:q])
  @user = @search.result.order("created_at DESC").to_a.uniq

  @results = @search.result
  @arrUsers = @results.to_a

end

#when you make a page that needs a fullname!!!
protected
	def configure_permitted_parameters

		#devise_parameter_sanitizer.for(:account_update) << :fullname
		#devise_parameter_sanitizer.for(:sign_up) <<
		#devise_parameter_sanitizer.for(:account_update) << :username
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,:username, :email, :password, :password_confirmation, :remember_me, :country, :city, :school, :major) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :username, :fullname, :description, :password, :current_password, :avatar, :country, :city, :school, :major, :school_description, :occupation, :company_name, :occupation_details) }

#devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
   # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
   # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :fullname, :password_confirmation, :current_password) }

	end
  rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end
end
