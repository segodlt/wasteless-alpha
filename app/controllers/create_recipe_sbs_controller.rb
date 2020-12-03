class CreateRecipeSbsController < ApplicationController
  include Wicked::Wizard

  steps :addDescription, :addDetails

  def show
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.user = current_user
    authorize @recipe

    render_wizard
  end


  def update
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.user = current_user
    authorize @recipe
    params[:recipe][:status] = 'active' if step == steps.last
    @recipe.update_attributes(create_recipe_sbs_params)
    render_wizard @recipe
  end


private
  def create_recipe_sbs_params
    params.require(:recipe).permit(:description, :usage, :difficulty, :duration, photos: [])

  end
end
