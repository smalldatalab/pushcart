class ItemsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :set_user_or_redirect
  before_action :set_item

  def swap_feedback
    @item.swap_feedback = params[:swap_feedback]
    if @item.save
      flash[:notice] = 'Your preference has been saved.'
    else
      flash[:error] = @item.errors
    end
    render 'show'
  end

protected

  def set_item
    @item = @user.items.find(params[:item_id])
  end

  def user_params
    params.require(:item).permit(:like_swap)
  end

end