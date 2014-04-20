class Api::V1::PurchasesController < Api::V1::BaseController

  before_action :set_user

  def index
    @purchases = @user.purchases
  end

  def show
    @purchase = @user.purchases.find params[:id]
  end

end
