ActiveAdmin.register User do
  permit_params  :email, :password , :first_name, :last_name, :date_of_birth, :phone, :sort_code , :reset_password_token, :reset_password_sent_at,:remember_created_at, :balance

  filter :email
  filter :first_name
  filter :last_name
  filter :date_of_birth
  filter :phone
  filter :sort_code
  filter :created_at
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
# On this page users can be edited deleted or created every field can be updated


form title: 'Create/Update User' do |f|
  inputs 'Details' do
    input :email
    input :password
    input :first_name, :required => true
    input :last_name, :required => true
    input :date_of_birth, :as => :date_picker 
    input :phone, :required => true
    input :sort_code
    input :balance
    f.semantic_errors *f.object.errors.keys
    li "Created at #{f.object.created_at}" unless f.object.new_record?
  end
  actions
end
end


