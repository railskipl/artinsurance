class AddAmountOfLossToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :amount_of_loss, :float
  end
end
