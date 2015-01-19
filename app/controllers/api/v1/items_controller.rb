class Api::V1::ItemsController < Api::V1::BaseCoachController

  before_action :set_user
  before_action :set_purchase, only: :index
  before_action :set_item, except: :index

  def index
    @items = @purchase.items
  end

  def show
  end

  def update
    if @item.update(item_params)
      render 'api/v1/items/show'
    else
      render json: @item.errors.full_messages, status: :unprocessable_entity
    end
  end

private

  def item_params
    params.require(:item).permit(:color_code)
  end

  def set_item
    @item = @user.items.find params[:id]
  end

  def set_purchase
    @purchase = @user.purchases.find params[:purchase_id]
  end

end
