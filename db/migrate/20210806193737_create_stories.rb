# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.belongs_to :account, null: false, foreign_key: true

      t.integer :content_type, null: false, default: 0
      t.integer :story_type,   null: false, default: 0

      t.string :name
      t.text :description, limit: 10_000

      t.json :image_data
      t.json :video_data

      t.timestamps
    end
  end
end
