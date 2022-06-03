class AddEmailToShopify < ActiveRecord::Migration[6.1]
  def change
    add_column :shopifies, :email, :string
  end
end
