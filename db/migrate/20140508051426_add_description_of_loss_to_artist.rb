class AddDescriptionOfLossToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :description_of_loss, :string
  end
end
