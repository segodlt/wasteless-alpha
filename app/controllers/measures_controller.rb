class MeasuresController < ApplicationController
  before_action :diplay_recipe, only: [:new, :create, :update, :destroy]

  def new
    @measure = Measure.new
    authorize @measure
  end

  def create
    @measure = Measure.new(measure_params)
    @measure.recipe = @recipe
    @recipe.measures.build
    authorize @measure
    #raise
    if @measure.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def update
    @measure = Measure.find(params[:id])
    authorize @measure
    @measure.update(new_params)
    @measure.recipe = @recipe
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @measure = Measure.find(params[:id])
    authorize @measure
    @measure.destroy
    redirect_to recipe_path(@recipe)
  end

  private

  def measure_params
    params.require(:measure).permit(:id, :quantity, :recipe_id, :unit_id, :optionnal, :ingredient_id)
  end

  def display_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

end
