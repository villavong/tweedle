class RevisersController < ApplicationController
  before_filter :require_permission, only: [:edit, :update, :destroy]

before_action :set_reviser, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!


  def index
    @revisers = current_user.revisers
  end

  def show
    @booked = Reservation.where("reviser_id = ? AND user_id = ?", @reviser.id, current_user.id).present? if current_user
    @reviser = Reviser.find(params[:id])
    @reviews = @reviser.reviews
    @revisers = current_user.revisers

   end


  def new
    @reviser = current_user.revisers.build
   # @reviser = current_user.build_reviser(params[:reviser])

  end

  def create
    @reviser = current_user.revisers.build(reviser_params)

    if @reviser.save
      redirect_to edit_user_registration_path(current_user.id), notice: "Became A Mentor!!"
    else
      render :new
    end
  end

  def edit
    if current_user.id == @reviser.user.id


    else
      redirect_to edit_user_registration_path(current_user.id), notice: "You dont have permission to see this"
    end
  end

  def update

    if @reviser.update(reviser_params)
      @reviser.save
      redirect_to edit_user_registration_path(current_user.id), notice: "Updated"
    else
      render :edit
    end
  end

    def destroy
      @reviser.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Mentor Service was successfully destroyed.' }
        format.json { head :no_content }
      end
    end


private

    def set_reviser
      @reviser = Reviser.find(11)

      # @reviser = Reviser.find(params[:id])
    end

    def reviser_params
      params.require(:reviser).permit(:description, :average_time, :essay_type, :max_pages, :price_per, :active, :paypal)
    end
    def require_permission
      @reviser = current_user.revisers.last
      if current_user.id != @reviser.user_id
        redirect_to root_path, notice: "Sorry, you're not allowed"
      end

    end
end
