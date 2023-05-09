class FixAddUserToBlogs < ActiveRecord::Migration[7.0]
  def change
    remove_reference :blogs, :users, index: true, foreign_key: true, null: false
    add_reference :blogs, :user, index: true, foreign_key: true, null: false
  end
end
