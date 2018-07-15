class AddCategoryToPartner < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :category, :integer, default: 0
  end
end
