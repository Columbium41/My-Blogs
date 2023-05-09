class AddUserToBlog < ActiveRecord::Migration[7.0]
  def change
    add_reference :blogs, :users, index: true, foreign_key: true, null: false
  end
end
