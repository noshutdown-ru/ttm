class AddSubscriptionToNotifierLog < ActiveRecord::Migration
  def up
    def change
      add_reference :notifier_logs, :subscription, foreign_key: true
    end
  end
  def down

  end
 end

