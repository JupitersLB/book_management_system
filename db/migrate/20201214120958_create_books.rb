class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :available_quantity
      t.integer :fee

      t.timestamps
    end
  end
end
