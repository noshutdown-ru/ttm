class ExtraTimeChangeToDate < ActiveRecord::Migration[6.1]
  def up
      change_column :extra_times, :date_added, :date
  end
  def down

  end
 end

