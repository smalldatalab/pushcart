class Api::V1::ItemsController < Api::V1::BaseController

  before_action :set_user
  before_action :set_purchase

  def index
    @items = @purchase.items
  end

  def show
    @item = @purchase.items.find params[:id]
  end

private

  def set_purchase
    @purchase = @user.purchases.find params[:purchase_id]
  end

end
