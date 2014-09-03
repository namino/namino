class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :urlname, null: false
      t.string :gh_login, null: false
      t.string :gh_repo_name, null: false
      t.string :title, null: false
      t.boolean :first_pushed, null: false, default: false
      t.string :hook_key, null: false
      t.timestamps
    end

    add_index :blogs, :urlname, unique: true
    add_index :blogs, [:gh_login, :gh_repo_name], unique: true
    add_index :blogs, :hook_key, unique: true
  end
end
