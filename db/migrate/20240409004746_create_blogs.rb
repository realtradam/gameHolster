class CreateBlogs < ActiveRecord::Migration[7.1]
  def change
    create_table :blogs do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.text :content, null: false
      t.string :image, default: 'https://tradam.dev/images/logo.png'
      t.date :live_date
      t.date :update_date

      t.timestamps
    end
  end
end
