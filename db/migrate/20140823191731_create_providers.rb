class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :gh_login
      t.string :uid, null: false
      t.string :token, null: false
      t.timestamps

      t.foreign_key :users, dependent: :delete
    end

    add_index :providers, [:user_id, :name], unique: true
    add_index :providers, [:name, :uid], unique: true
    add_index :providers, :gh_login, unique: true
  end
end
