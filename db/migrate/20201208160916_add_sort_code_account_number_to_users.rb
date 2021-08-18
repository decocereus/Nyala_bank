class AddSortCodeAccountNumberToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sort_code, :string, :default => "050505"
  end
end
