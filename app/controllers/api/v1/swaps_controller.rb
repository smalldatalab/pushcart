class Api::V1::SwapsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!, only: :create
  before_action :set_coach,             only: :create

  def index
    @swaps = Swap.all
  end

  def create
    @swap = Swap.new(swap_params)
    if @swap.save
      render 'api/v1/swaps/show'
    else
      render json: @swap.errors.full_messages, status: :unprocessable_entity
    end
  end

private

  def swap_params
    params.require(:swap).permit( 
                                  :name, 
                                  :swap_category_id
                                 )
  end

end
