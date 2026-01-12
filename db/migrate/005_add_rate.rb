class AddRate < ActiveRecord::Migration[6.1]
   def change
     add_column :subscriptions, :rate, :float, null: false, default: 0.0
   end
end

