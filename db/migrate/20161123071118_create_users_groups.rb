class CreateUsersGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :users_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group, foreign_key: true
    end
  end
end
