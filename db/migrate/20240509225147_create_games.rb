class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.belongs_to :user
      t.string :title
      t.string :titleSlug
      #t.text :body
      #t.integer :status, default: 0
      #t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
