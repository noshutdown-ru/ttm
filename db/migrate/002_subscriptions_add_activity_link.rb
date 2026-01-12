class SubscriptionsAddActivityLink < ActiveRecord::Migration[6.1]
  def change
    add_reference :subscriptions, :activity, foreign_key: { to_table: :enumerations }
  end
end

