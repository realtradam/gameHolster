class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :titleSlug
      t.string :description
      t.string :img_rendering
      #t.integer :status, default: 0
      #t.integer :order, default: 0

      t.timestamps
    end
    add_reference :games, :user, null: false, foreign_key: true
  end
end
