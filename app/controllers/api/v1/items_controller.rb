class Api::V1::ItemsController < Api::V1::BaseCoachController

  before_action :set_user
  before_action :set_purchase, only: :index

  def index
    @items = @purchase.items
  end

  def show
    @item = @user.items.find params[:id]
  end

private

  def set_purchase
    @purchase = @user.purchases.find params[:purchase_id]
  end

end
