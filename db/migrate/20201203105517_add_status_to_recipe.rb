class AddStatusToRecipe < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :status, :string
  end
end
