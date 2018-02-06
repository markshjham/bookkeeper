class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :items, :amound, :amount
    rename_column :items, :name, :description
  end
end
