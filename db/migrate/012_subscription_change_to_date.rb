class SubscriptionChangeToDate < ActiveRecord::Migration
  def up
      change_column :subscriptions, :begindate, :date
      change_column :subscriptions, :enddate, :date
  end
  def down

  end
 end

