class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]

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
	
		 #send request to paypal
		 @reservation = current_user.reservations.create(reservation_params)
		@reviser = Reviser.find(params[:reviser_id])

		if @reservation

			require 'paypal-sdk-adaptivepayments'


		reviserprice = @reservation.total
		commission = 0.05

		# Build API call
		@api = PayPal::SDK::AdaptivePayments.new
		@pay = @api.build_pay({
			:actionType => "PAY",
			:cancelUrl => "http://4e8c6120.ngrok.io/revisers/#{@reviser.id}",
			:returnUrl => "http://4e8c6120.ngrok.io/revisers/#{@reviser.id}",
			:currencyCode => "USD",
			:feesPayer => "SENDER",
			#ipnNotificationUrl                                     ipn_notify
			:ipnNotificationUrl => "http://4e8c6120.ngrok.io/paypal/ipn_notify",
			:item_name => "@reservation.reviser.essay_type",
			:item_number => "@reservation.id",
			:receiverList => {
				:receiver => [
					{
						:amount => reviserprice * 0.1,
						:email => "birdsinthatcity-facilitator@gmail.com",
						# :primary => true
					},
					{
						#Before deploying make sure to change the email to current_user.email
						:amount => reviserprice * 0.9,
						:email => "birdsinthatcity-buyer@gmail.com",
						# :primary => false
					}
				]
			},
		} || default_api_value)

		# Make API call
					@pay_response = @api.pay(@pay)

		# Access Response
				if @pay_response.success? && @pay_response.payment_exec_status != "ERROR"
				  @pay_response.payKey

					redirect_to @api.payment_url(@pay_response)  # Url to complete payment

					# redirect_to @reservation.room, alert: "Yes"

				else
				  @pay_response.error
					redirect_to @reservation.reviser, alert: "FUCK"
				end


		else
			redirect_to @reservation.reviser, alert: "Opps, Something went wrong!!"
	end
end

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
	@essays = current_user.reservations 
end

def your_reservations
	@revisers = current_user.reviser
end


private

def is_conflict(due_date)
	reviser = Reviser.find(params[:reviser_id])

	check = reviser.reservations.where("? < due_date", due_date)
	check.size > 0? true : false
end

def reservation_params
	params.require(:reservation).permit(:due_date, :price, :total, :document, :rubric, :pages, :reviser_id, :status)
end

end