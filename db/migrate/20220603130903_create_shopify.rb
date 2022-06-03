class CreateShopify < ActiveRecord::Migration[6.1]
  def change
    create_table :shopifies do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :country
      t.string :gender
      t.string :industry
      t.string :job_title
      t.string :level_of_education

      t.timestamps
    end
  end
end
