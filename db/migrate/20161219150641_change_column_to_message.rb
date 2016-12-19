class ChangeColumnToMessage < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :body, :string, null: false
  end
end
