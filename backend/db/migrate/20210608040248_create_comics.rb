class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.string :title
      t.string :publisher
      t.string :creators
      t.string :img_url
      t.float :price
      t.integer :client_id
    end
  end
end
