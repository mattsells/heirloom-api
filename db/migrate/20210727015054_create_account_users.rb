class CreateAccountUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :account_users do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :role

      t.timestamps
    end
  end
end
