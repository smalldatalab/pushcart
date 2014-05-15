class Api::V1::PurchasesController < Api::V1::BaseController

  before_action :set_user, :set_variables

  def index
    @purchases = @user.purchases
  end

  def show
    @purchase = @user.purchases.find params[:id]
  end

private

  def set_variables
    @show_items = true if params[:show_items]
  end

end
