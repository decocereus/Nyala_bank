class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :amount, null: false
      t.references :currency
      t.references :sender, null: false
      t.string :recipient_name, null: false
      t.bigint :sort_code, null: false
      t.bigint :account_number, null: false

      t.timestamps
    end
  end
end
