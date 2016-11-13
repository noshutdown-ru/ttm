class AddSubscriptionToNotifierLog < ActiveRecord::Migration
   def change
     add_reference :notifier_logs, :subscription, foreign_key: true
   end
 end

