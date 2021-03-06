class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @recipes = policy_scope(Recipe).where(user_id:current_user)
  end

  def show
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  def new
    @recipe = Recipe.new
    @recipe.measures.build
    authorize @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    authorize @recipe
    if @recipe.save
      redirect_to recipe_create_recipe_sb_path(:addDescription, recipe_id: @recipe.id)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  def update
    new_params = recipe_params
    @recipe = Recipe.find(params[:id])
    authorize @recipe
    @recipe.update(new_params)
    raise
    # Créer les nouvelles mesures avec les params
    new_measure_params = params.select{ |p| p.include?('new_measure_id') }
    new_measure_params.each do |new_measure_param|
      new_measure = Measure.new
      new_measure.recipe = @recipe
      new_measure.ingredient_id = new_measure_param[1]

      new_measure_number = new_measure_param[0].split('_').last
      new_measure.quantity = params["new_measure_quantity_#{new_measure_number}"]

      params_optionnal = params["new_measure_optionnal_#{new_measure_number}"]
      if params_optionnal
        new_measure.optionnal = true
      else
        new_measure.optionnal = false
      end
      new_measure.save
    end

    redirect_to recipe_create_recipe_sb_path(:addDescription, recipe_id: @recipe.id)
  end

private

  def recipe_params
    params.require(:recipe).permit(:title, :category_id, :id, measures_attributes: [:id, :quantity, :recipe_id, :unit_id, :optionnal, :ingredient_id])
  end

end
