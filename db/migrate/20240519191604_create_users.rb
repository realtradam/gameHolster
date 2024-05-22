class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :user_name # we need this for game urls
      t.string :identifier
      t.string :access_token_digest
      t.json :user_data

      t.timestamps
    end
    #add_index :users, :identifier, unique: true
  end
end
