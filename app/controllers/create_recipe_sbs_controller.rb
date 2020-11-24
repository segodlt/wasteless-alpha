class CreateRecipeSbsController < ApplicationController
  include Wicked::Wizard

  steps :addIngredient, :addDetails

  def show
    render_wizard
  end

end
