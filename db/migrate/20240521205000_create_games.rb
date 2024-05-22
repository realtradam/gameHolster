class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :titleSlug
      #t.text :body
      #t.integer :status, default: 0
      #t.integer :order, default: 0

      t.timestamps
    end
    add_reference :games, :user, null: false, foreign_key: true
  end
end
