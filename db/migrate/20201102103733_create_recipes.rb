class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :difficulty
      t.integer :duration
      t.text :usage

      t.timestamps
    end
  end
end
