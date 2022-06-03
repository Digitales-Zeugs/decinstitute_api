class AddStatusToShopify < ActiveRecord::Migration[6.1]
  def change
    add_column :shopifies, :status, :boolean
  end
end
