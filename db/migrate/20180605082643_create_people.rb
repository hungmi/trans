class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :en_name
      t.string :zh_name
      t.string :en_title
      t.string :zh_title
      t.text :en_description
      t.text :zh_description

      t.timestamps
    end
  end
end