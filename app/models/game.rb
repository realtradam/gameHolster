require "zip"

class Game < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  #enum status: { 
  #  draft: 0,
  #  published: 1
  #}
  belongs_to :user
  has_many_attached :game_files
  has_one_attached :zip
  has_one_attached :card_img
  has_one_attached :char_img
  has_one_attached :title_img
  has_and_belongs_to_many :tags

  def save_zip(zip)
      Zip::File.open(zip) do |zipfile|

        zipfile.each do |entry|
          if entry.file?
            path_name = entry.name.rpartition('/')
            name_extension = path_name.last.rpartition('.')

            Tempfile.open([name_extension.first, name_extension[1] + name_extension.last]) do |temp_file|
              entry.extract(temp_file.path) { true }
              self.game_files.attach(io: File.open(temp_file.path), filename: path_name.last)
              self.game_files.last.blob.filepath = path_name.first.delete_suffix('/').delete_prefix('/')

              # saving the game wont have the blob saved so we need to do it manually
              self.game_files.last.blob.save 
            end

          end
        end
      end

  end
end
