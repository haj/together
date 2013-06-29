class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :domain
      t.string :schema
    end
  end
end
