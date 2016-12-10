class ExtraTimeChangeToDate< ActiveRecord::Migration
  def up
      change_column :extra_times, :date_added, :date
  end
  def down

  end
 end

