class AddPathToActiveStorageBlobs < ActiveRecord::Migration[7.1]
  def change
    add_column :active_storage_blobs, :filepath, :string, null: false, default: ''
  end
end
