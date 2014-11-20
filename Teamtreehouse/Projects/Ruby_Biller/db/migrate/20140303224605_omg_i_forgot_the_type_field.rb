class OmgIForgotTheTypeField < ActiveRecord::Migration
  def change
  	add_column :account_entries, :type, :string
  end
end
