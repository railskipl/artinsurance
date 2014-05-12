class AddDateToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :date, :datetime
  end
end
