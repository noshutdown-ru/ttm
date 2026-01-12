class SubscriptionsAddTrackerLink < ActiveRecord::Migration[6.1]
  def change
   add_reference :subscriptions, :tracker, foreign_key: true
  end
end
