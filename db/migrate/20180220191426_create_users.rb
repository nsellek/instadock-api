class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :jwt_token
      t.string :instagram_code
      t.string :username
      t.string :instagram_token

      t.timestamps
    end
  end
end
