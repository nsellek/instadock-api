class CreateApiCredentials < ActiveRecord::Migration[5.1]
  def change
    create_table :api_credentials do |t|
      t.string :api_key
      t.string :api_secret
    end
  end
end
