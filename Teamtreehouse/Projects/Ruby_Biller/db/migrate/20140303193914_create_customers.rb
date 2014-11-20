class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name, :about
      t.integer :balance
      t.timestamps
    end
  end
end
