class RemoveOldTables < ActiveRecord::Migration
  def up
  	Customer.all.each do |c|
  		Account.create(name: c.name, about: c.about)
  	end
 
  	Employee.all.each do |e|
  		Account.create(name: e.name, email: e.email)
  	end

  	drop_table :customers
  	drop_table :employees
  end

  def down
  end
end
