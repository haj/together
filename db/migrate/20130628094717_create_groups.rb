class CreateGroups < ActiveRecord::Migration
  def change
    Tenant.for_each_schema do
      create_table :groups do |t|
        t.string :name
      end

      create_table :memberships do |t|
        t.integer :user_id
        t.integer :group_id
      end

      add_index :memberships, :user_id
      add_index :memberships, :group_id

    end
  end
end
