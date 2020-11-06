class UnitsController < ApplicationController
  def index
    @units = policy_scope(Units).order(created_at: :desc)
  end
end
