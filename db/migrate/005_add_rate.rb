class AddRate < ActiveRecord::Migration
   def change
     add_column :subscriptions, :rate, :float, null: false, default: 0.0
   end
end

