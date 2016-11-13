class SubscriptionAddBeginEnd < ActiveRecord::Migration
   def change
     add_column :subscriptions, :begindate, :datetime
     add_index :subscriptions, :begindate
     add_column :subscriptions, :enddate, :datetime
     add_index :subscriptions, :enddate
   end
 end

