class IngredientsController < ApplicationController
  skip_after_action :verify_authorized, only: [:create_json]

  def index
    @ingredients = policy_scope(Ingredient).order(created_at: :desc)
  end
end
