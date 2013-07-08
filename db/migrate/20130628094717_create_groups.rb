class CreateGroups < ActiveRecord::Migration
  def up
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

  def down
    Tenant.for_each_schema do
      drop_table :groups
      drop_table :memberships
    end
  end
end
