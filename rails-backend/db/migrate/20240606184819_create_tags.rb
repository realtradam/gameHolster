class CreateTags < ActiveRecord::Migration[7.1]
  def change
    create_table :tags do |t|
      t.string :tag_type, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
