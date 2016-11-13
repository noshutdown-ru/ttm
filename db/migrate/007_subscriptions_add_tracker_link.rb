class SubscriptionsAddTrackerLink < ActiveRecord::Migration
  def change
   add_reference :subscriptions, :tracker, foreign_key: true
  end
end
