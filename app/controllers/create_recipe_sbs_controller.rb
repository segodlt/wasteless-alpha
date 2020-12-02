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
    #raise
    @recipe.update_attributes(create_recipe_sbs_params)
    render_wizard @recipe
  end


private
  def create_recipe_sbs_params(step)
    permitted_attributes = case step
      when "addDescription"
        [:description, :usage]
      when "addDetails"
        [:difficulty, :duration, photos: []]
      params.require(:create_recipe_sbs).permit(permitted_attributes).merge(form_step: step)
    end
  end

end
