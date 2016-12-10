class AddSubscriptionToNotifierLog < ActiveRecord::Migration
  def up
      add_reference :notifier_logs, :subscription, foreign_key: true
  end
  def down

  end
 end

