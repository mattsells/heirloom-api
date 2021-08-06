# frozen_string_literal: true

class CreateRecipeStories < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_stories do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.belongs_to :story,  null: false, foreign_key: true

      t.timestamps
    end
  end
end
