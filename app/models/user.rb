class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions
  validates :phone, numericality: {only_integer: true}
  validates :phone, length: {minimum:10}
  validates_format_of :first_name, with: /[-a-z]+/
  validates_format_of :last_name, with: /[-a-z]+/
end
