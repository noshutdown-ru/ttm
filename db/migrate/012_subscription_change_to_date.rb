class SubscriptionChangeToDate < ActiveRecord::Migration
   def change
     change_column :subscriptions, :begindate, :date
     change_column :subscriptions, :enddate, :date
   end
 end

