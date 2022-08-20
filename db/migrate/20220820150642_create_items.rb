class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :price,              null: false
      t.string :name,                null: false
      t.text :introduction,          null: false

      t.timestamps
    end
  end
end
