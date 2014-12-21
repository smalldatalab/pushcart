class Api::V1::SwapCategoriesController < Api::V1::BaseController

  def index
    @swap_categories = SwapCategory.all
  end

end
