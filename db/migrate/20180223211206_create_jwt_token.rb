class CreateJwtToken < ActiveRecord::Migration[5.1]
  def change
    create_table :jwt_tokens do |t|
      t.string :jwt_token
      t.references :user, foreign_key: true
    end
  end
end
