class ExtraTimeChangeToDate< ActiveRecord::Migration
   def change
     change_column :extra_times, :date_added, :date
   end
 end

