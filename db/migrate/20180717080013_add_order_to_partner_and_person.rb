class AddOrderToPartnerAndPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :partners, :order, :integer
    add_column :people, :order, :integer
  end
end
