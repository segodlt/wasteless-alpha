class CreateRecipeSbsController < ApplicationController
  include Wicked::Wizard

  steps :addIngredient, :addDetails

  def show
    @user = current_user
    @recipe = Recipe.find(params[:recipe_id])
    render_wizard
  end

private

  def create_recipe_sbs_params
    params.require(:recipe).permit(:title, :description, :category_id, :usage)
  end

  # , photos: [], measures_attributes: [:id, :quantity, :recipe_id, :unit_id, :optionnal, :ingredient_id]

end

end
