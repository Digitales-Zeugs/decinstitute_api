class AddResponseToShopify < ActiveRecord::Migration[6.1]
  def change
    add_column :shopifies, :response, :text
  end
end
