class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.belongs_to :user, null: false
      t.belongs_to :blog, null: false
      t.timestamps

      t.foreign_key :users, dependent: :delete
      t.foreign_key :blogs, dependent: :delete
    end

    add_index :ownerships, [:user_id, :blog_id], unique: true
  end
end
