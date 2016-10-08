class CreateRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false, unique: true
      t.boolean :superadmin, null: false, default: false, unique: true
      t.boolean :default_user, null: false, default: false, unique: true
      t.boolean :custom, null: false, default: true, unique: false
      t.text :description, null: false, unique: true
      t.string :code, null: false, unique: true

      t.timestamps
    end
  end
end