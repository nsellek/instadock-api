class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    change_column :jwt_tokens, :jwt_token, :text
  end
end
