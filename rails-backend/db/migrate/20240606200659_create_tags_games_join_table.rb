class CreateTagsGamesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :tags, :games do |t|
      t.index :tag_id
      t.index :game_id
    end
  end
end
