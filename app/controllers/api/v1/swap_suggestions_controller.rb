class Api::V1::SwapSuggestionsController < Api::V1::BaseCoachController

  before_action :set_user

  def index
    @swap_suggestions = @user.swap_suggestions
  end

  def show
    @swap_suggestion = @user.swap_suggestions.find params[:id]
  end

  def create
    @swap_suggestion = @user.swap_suggestions.new(swap_suggestion_params)
    @swap_suggestion.coach = @coach
    if @swap_suggestion.save
      render 'api/v1/swap_suggestions/show'
    else
      render json: @swap_suggestion.errors.full_messages, status: :unprocessable_entity
    end
  end

private

  def swap_suggestion_params
    params.require(:swap_suggestion).permit( 
                                            :swap_id,
                                            :item_id
                                           )
  end

end
