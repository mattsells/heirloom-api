# frozen_string_literal: true

class CreateAccountUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :account_users do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.integer :role, default: 0

      t.timestamps
    end
  end
end
