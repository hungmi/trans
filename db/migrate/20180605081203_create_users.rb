class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :role
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :name
  end
end
