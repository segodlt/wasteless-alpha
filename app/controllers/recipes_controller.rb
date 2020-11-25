class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  include Wicked::Wizard

  steps :add_ingredient, :add_details

  def index
   @recipes = policy_scope(Recipe).where(user_id:current_user)
  end

  def show
    @recipe = Recipe.find(params[:recipe_id])
    authorize @recipe
    render_wizard
  end

  def new
    @recipe = Recipe.new
    authorize @recipe
    render_wizard
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize @recipe
    if @recipe.save
      redirect_to wizard_path(steps.first, recipe_id: @recipe.id)
    else
      render :new
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.user = current_user
    authorize @recipe
    @recipe.update_attributes(params[:recipe_params])
    render_wizard @recipe
  end

  def edit
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

private

  def recipe_params
    params.require(:recipe).permit(:title, :description, :category_id, :usage)
  end

  # , photos: [], measures_attributes: [:id, :quantity, :recipe_id, :unit_id, :optionnal, :ingredient_id]

end
