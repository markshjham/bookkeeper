class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :amound
      t.boolean :debit
      t.string :category
      t.string :subcategory
      t.date :transaction_date

      t.timestamps
    end
  end
end
