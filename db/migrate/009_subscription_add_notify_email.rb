class SubscriptionAddNotifyEmail < ActiveRecord::Migration
   def change
     add_column :subscriptions, :notify_email, :string
   end
 end

