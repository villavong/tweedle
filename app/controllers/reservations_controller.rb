class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]
skip_before_filter :verify_authenticity_token
# before_action :set_s3_direct_post, only: [:create]
def preload

	reviser = Reviser.find(params[:reviser_id])
	today = Date.today
	reservations = reviser.reservations.where("due_date >= ?", today, today)

	render json: reservations

end

def preview
	due_date = Date.parse(params[:due_date])

	output = {
		conflict: is_conflict(due_date)
	}


	render json: output
end





def create

	reviser = Reviser.find(params[:reviser_id])
		@reservation = current_user.reservations.create(reservation_params)

		if @reservation
			# send request to PayPal
			values = {
				business: reviser.user.email,
				cmd: '_xclick',
				upload: 1,
				notify_url: 'http://f48c9161.ngrok.io/notify',
				amount: @reservation.total,
				item_name: @reservation.reviser.essay_type,
				item_number: @reservation.id,
				quantity: '1',
				return: 'http://f48c9161.ngrok.io/your_essays'
			}

			redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
		else
			redirect_to @reservation.reviser, alert: "Oops, something went wrong..."
		end




end
# Chained payments
# def create

# 		 #send request to paypal
# 		 @reservation = current_user.reservations.create(reservation_params)
# 		@reviser = Reviser.find(params[:reviser_id])



# 			require 'paypal-sdk-adaptivepayments'
# if @reservation

# 		reviserprice = @reservation.total
# 		commission = 0.05

# 		# Build API call
# 		@api = PayPal::SDK::AdaptivePayments.new

# 		@pay = @api.build_pay({
# 			:actionType => "PAY",
# 			:cancelUrl => "http://f9643d7b.ngrok.io/revisers/#{@reviser.id}",
# 			:returnUrl => "http://f9643d7b.ngrok.io/users/#{@reviser.user.id}",
# 			:currencyCode => "USD",
# 			:feesPayer => "SENDER",
# 			notify_url: "http://f9643d7b.ngrok.io/notify",
# 			item_number: @reservation.id,
# 			#ipnNotificationUrl                                     ipn_notify
# 			# :ipnNotificationUrl => "http://f9643d7b.ngrok.io/pay/paypal",


# 			:receiverList => {
# 				:receiver => [
# 					{
# 						#Before deploying make sure to change the email to our company email
# 						:amount => reviserprice * 0.1,
# 						:email => "birdsinthatcity-facilitator@gmail.com",
# 						# ]:primary => true
# 					},
# 					{
# 						#Before deploying make sure to change the email verified seller email
# 						:amount => reviserprice * 0.9,
# 						:email => "birdsinthatcity-buyer@gmail.com",
# 						# :primary => false
# 					}
# 				]
# 			},
# 		} || default_api_value)

# 		# Make API call
# 					@pay_response = @api.pay(@pay)

# 		# Access Response


# 				if @pay_response.success? && @pay_response.payment_exec_status != "ERROR"

# 				  @pay_response.payKey
# 				  @pay_response.paymentExecStatus
#   					@pay_response.payErrorList
#   					@pay_response.paymentInfoList
#  					 @pay_response.sender

# 					redirect_to @api.payment_url(@pay_response) # Url to complete payment

# 					# redirect_to @reservation.room, alert: "Yes"

# 				else
# 				  @pay_response.error

# 				end


# 		else
# 			redirect_to @reservation.reviser, alert: "Opps, Something went wrong!!"
# 		end
# 	end


protect_from_forgery except: [:notify]


def notify
	params.permit!
	status = params[:payment_status]

	reservation = Reservation.find(params[:item_number])

			if status == "Completed"
				reservation.update_attributes status: true
			else
				reservation.destroy
			end

		render nothing: true
end




#like your trips
protect_from_forgery except: [:your_essays]
def your_essays
	@essays = current_user.reservations.where("status = ?", true)
	@user = current_user



end

def your_reservations
	@revisers = current_user.revisers
	@user = current_user
end
# def notify
# 	@notify = Paypal::Notification.new(request.raw_post)
# 	params.permit!
# 	status = params[:payment_status]

# 	reservation = Reservation.find(params[:reservation_id])

# 	if status == "Completed"
# 		reservation.update_attribute :status, true
# 	else
# 		reservation.destroy
# 	end
# 	render nothing: true
# end

private

def is_conflict(due_date)
	reviser = Reviser.find(params[:reviser_id])

	check = reviser.reservations.where("? < due_date", due_date)
	check.size > 0? true : false
end

def reservation_params
	params.require(:reservation).permit(:due_date, :price, :total, :document, :direct_upload_url, :rubric, :pages, :reviser_id, :status)
end

end
