class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :type
      t.string :name, :email, :about
      t.timestamps
    end
  end
end
