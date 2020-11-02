class CreateMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :measures do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :quantity
      t.boolean :optionnal
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
