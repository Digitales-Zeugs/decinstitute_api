class AddProductToShopify < ActiveRecord::Migration[6.1]
  def change
    add_column :shopifies, :product, :string
    add_column :shopifies, :product_id, :string
  end
end
