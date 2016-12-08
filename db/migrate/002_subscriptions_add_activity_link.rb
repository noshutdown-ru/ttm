class SubscriptionsAddActivityLink < ActiveRecord::Migration
  def up
    def change
      add_reference :subscriptions, :activity
      add_foreign_key :subscriptions, :enumerations, {column: 'activity_id'}
    end
  end
end

