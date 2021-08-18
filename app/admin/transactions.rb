ActiveAdmin.register Transaction do

  permit_params :sender_id ,:currency_id , :amount , :recipient_name , :sort_code, :account_number, :balance

  filter :sender_id
  filter :currency_id
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
  filter :amount
  filter :recipient_name
  filter :sort_code
  filter :account_number

  #Transactions can be created,edited or deleted on this page

  form title: 'Make Transaction' do |f|
    f.inputs 'Transaction' do
      f.inputs :sender_id  # To make a transaction you need input the sender id which can be seen on the user tab
      f.inputs :currency_id # Put the currency id
      f.inputs :amount
      f.inputs :recipient_name
      f.inputs :sort_code
      f.inputs :account_number
    end
    f.actions
  end
end
