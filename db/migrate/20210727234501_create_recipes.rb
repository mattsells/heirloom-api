# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.belongs_to :account, null: false, foreign_key: true

      t.string :name, null: false, length: 200

      t.json :ingredients
      t.json :directions

      t.timestamps
    end
  end
end
