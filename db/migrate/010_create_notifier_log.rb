class CreateNotifierLog < ActiveRecord::Migration
  def change
    create_table :notifier_logs do |t|
      t.string :email
      t.datetime :previous
    end
  end
end

