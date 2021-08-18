class Transaction < ApplicationRecord
  belongs_to :sender, :class_name => 'User'
  belongs_to :currency, :class_name => 'Currency'
end
