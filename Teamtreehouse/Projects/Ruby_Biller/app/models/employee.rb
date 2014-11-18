class Employee < ActiveRecord::Base
	has_many :time_entries
end
