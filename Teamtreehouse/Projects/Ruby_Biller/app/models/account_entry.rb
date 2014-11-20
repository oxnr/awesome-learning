class AccountEntry < ActiveRecord::Base
  belongs_to :account

  validates :account_id, presence: true
  validates_associated :account
end