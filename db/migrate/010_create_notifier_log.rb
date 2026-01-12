class CreateNotifierLog < ActiveRecord::Migration[6.1]
  def change
    create_table :notifier_logs do |t|
      t.string :email
      t.datetime :previous
    end
  end
end

