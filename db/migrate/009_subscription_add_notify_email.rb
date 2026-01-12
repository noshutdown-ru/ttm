class SubscriptionAddNotifyEmail < ActiveRecord::Migration[6.1]
   def change
     add_column :subscriptions, :notify_email, :string
   end
 end

