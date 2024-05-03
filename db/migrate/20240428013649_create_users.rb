class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :identifier
      t.string :access_token_digest
      t.string :salt
      t.json :user_data

      t.timestamps
    end
    add_index :users, :identifier, unique: true
  end
end
