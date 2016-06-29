class RevisersController < ApplicationController
  
before_action :set_reviser, only: [:show, :edit, :update]
before_action :authenticate_user!, except: [:show]


  def index
    @revisers = current_user.revisers
  end

  def show
    @booked = Reservation.where("reviser_id = ? AND user_id = ?", @reviser.id, current_user.id).present? if current_user
    @reviews = @reviser.reviews
    
   end
  

  def new
    @reviser = current_user.revisers.build
   # @reviser = current_user.build_reviser(params[:reviser])
  
  end

  def create
    @reviser = current_user.revisers.build(reviser_params)

    if @reviser.save
      redirect_to edit_reviser_path(@reviser), notice: "saved...."
    else 
      render :new
    end
  end

  def edit
    if current_user.id == @reviser.user.id 
      
    else
      redirect_to root_path, notice: "you dont have permission to see this"
  end
end

  def update
    
    if @reviser.update(reviser_params)
      redirect_to edit_reviser_path(@reviser), notice: "updated.."
    else
      render :edit
    end
  end

private 

def set_reviser
  @reviser = Reviser.find(params[:id])
end

  def reviser_params
    params.require(:reviser).permit(:description, :average_time, :essay_type, :max_pages, :price_per, :active)
end

end
