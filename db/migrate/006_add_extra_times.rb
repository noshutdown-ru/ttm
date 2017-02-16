class AddExtraTimes < ActiveRecord::Migration
  def change
    create_table :extra_times do |t|
      t.belongs_to :subscription, index: true
      t.float :hours
      t.datetime :date_added
    end
  end
end
