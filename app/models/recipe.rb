class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :measures
  has_many :ingredients, through: :measures
  has_many :units, through: :measures
  accepts_nested_attributes_for :measures

  validates :title, :description, :usage, presence: true
  validates_associated :ingredients, :measures, presence: true

  cattr_accessor :form_steps do
    %w(addDescription addDetails)
  end

  attr_accessor :form_step

  def required_for_create_recipe_sbs?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?

    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end

end
