class Api::V1::ItemizablesController < Api::V1::BaseCoachController

  before_action :set_user
  before_action :set_purchase, only: :index
  before_action :set_itemizable, except: :index

  def index
    @itemizables = @purchase.itemizables.includes(:item)
  end

  def show
  end

  def update
    if @itemizable.update(itemizable_params.merge({coach_id: @coach.id}))
      render 'api/v1/itemizables/show'
    else
      render json: @itemizable.errors.full_messages, status: :unprocessable_entity
    end
  end

private

  def itemizable_params
    params.require(:itemizable).permit(:color_code, :swap_id)
  end

  def set_itemizable
    @itemizable = @user.itemizables.includes(:item).find params[:id]
  end

  def set_purchase
    @purchase = @user.purchases.find params[:purchase_id]
  end

end
