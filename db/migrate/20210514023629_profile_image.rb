class ProfileImage < ActiveRecord::Migration[5.2]
  def change
    drop_table :post_images
  end
end
