class ExtraTimeChangeToDate< ActiveRecord::Migration
  def up
    def change
      change_column :extra_times, :date_added, :date
    end
  end
 end

