class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer     :user_id,     null: false
      t.string      :name,        null: false, default: ''
      t.string      :avatar_url,  null: false
      t.string      :description, null: false, default: ''
      t.timestamps

      t.foreign_key :users, dependent: :delete
    end

    add_index :profiles, :user_id, unique: true
  end
end
