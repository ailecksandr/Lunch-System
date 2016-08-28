class CreateApiKeys < ActiveRecord::Migration[5.0]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.datetime :expired_at
      t.boolean :static, default: false

      t.timestamps
    end
  end
end
