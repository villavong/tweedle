class VerificationsController < ApplicationController
	before_action :authenticate_user!



 # module ResponseStatus
 #          Status = { :success => ["Success", "SuccessWithWarning"],
 #                     :warning => ["Warning", "SuccessWithWarning", "FailureWithWarning"],
 #                     :failure => ["Failure", "FailureWithWarning"] }
 #                end  



# protect_from_forgery except: [:create]
def create

require 'paypal-sdk-adaptiveaccounts'
  
	 @user = current_user
	# @verification = current_user.verification.create(verification_params)

	@verification = current_user.create_verification(verification_params)
 
begin

@api = PayPal::SDK::AdaptiveAccounts::API.new( :device_ipaddress => "127.0.0.1" )

# Build request object
@get_verified_status = @api.build_get_verified_status({
  :emailAddress => "@user.verification.paypal_email",
  :matchCriteria => "NAME",
  :firstName => "@user.verification.paypal_firstname",
  :lastName => "@user.verification.paypal_lastname" 
  })
  # Make API call & get response
 @get_verified_status_response = @api.get_verified_status(@get_verified_status)
    puts "response: #{ActiveSupport::JSON.decode(@get_verified_status_response.to_json)}"
    if @get_verified_status_response.success?
      puts "Status: #{@get_verified_status_response.accountStatus}"
      puts "Code: #{@get_verified_status_response.countryCode}"
      puts "Info: #{ActiveSupport::JSON.decode(@get_verified_status_response.userInfo.to_json)}"
      redirect_to edit_user_registration_path, alert: "success"
    else
      puts "Error: #{ActiveSupport::JSON.decode(@get_verified_status_response.error.to_json)}"
      redirect_to edit_user_registration_path, alert: "failed"
      @verification.destroy
    end
  rescue => exception
    puts exception.backtrace[0].split(",").first
  end

# status = params[:account_status]
# verification = current_user.verification

# if status == "VERIFIED" 
  
#   redirect_to edit_user_registration_path, alert: "success"
#   verification.update_attributes paypal_verified: true
  
#   else
#    redirect_to edit_user_registration_path, alert: "failed"
#    verification.update_attributes paypal_verified: false
   
#   end

      



  end 






# def get_verified_status
# 	require 'paypal-sdk-adaptiveaccounts'
# @api = PayPal::SDK::AdaptiveAccounts::API.new( :device_ipaddress => "127.0.0.1" )

# # Build request object
# @get_verified_status = @api.build_get_verified_status({
#   :emailAddress => "newEmailAddress@paypal.com",
#   :matchCriteria => "NONE" })

# # Make API call & get response
# @get_verified_status_response = @api.get_verified_status(@get_verified_status)

# # Access Response
# if @get_verified_status_response.success?
#   @get_verified_status_response.accountStatus
#   @get_verified_status_response.countryCode
#   @get_verified_status_response.userInfo
# else
#   @get_verified_status_response.error
# end
#      end

# status = params[:accountStatus]
# verification = Verification.find(params[:emailAddress])

# if status != "VERIFIED" || @get_verified_status_response.error?
  
#   redirect_to edit_user_registration_path(current_user)
#     verification.update_attributes paypal_verified: false
#     verification.destroy
  
#   elsif status == "VERIFIED"
#     redirect_to edit_user_registration_path(current_user)
#   verification.update_attributes paypal_verified: true

# else
# redirect_to edit_user_registration_path(current_user)
#     verification.update_attributes paypal_verified: false
#     verification.destroy
# end

# end
# def okay
#       params.permit!
# 	status = params[:accountStatus]

# verification = Verification.find(params[:emailAddress])

# if status == "VERIFIED"
# 	verification.update_attributes paypal_verified: true
# else 
# 	verification.update_attributes paypal_verified: false
# 	verification.destroy
# end
# else
# 	redirect_to @user.edit
# end
	
# end


	private
		def verification_params
			params.require(:verification).permit(:user_id, :paypal_firstname, :paypal_lastname, :paypal_email, :paypal_verified)
		end


end

