namespace :redmine do
   namespace :plugins do
     namespace :ttm do
 
       desc 'Sends notifications about soon expiring subscriptions'
       task :notify => :environment do
         #include Redmine::I18n

					Project.all.each do |p|
						subs = p.subscriptions

						if subs
							almost_over = subs.select do |s|
                s.left <= Setting.plugin_ttm['ttm_hours_to_warning'].to_f && s.status != 'closed'
              end
               
              ActionMailer::Base.raise_delivery_errors = true
              almost_over.select {|s| !s.notify_email.blank? }.each do |s|
                record = TTM::NotifierLog.where(email: s.notify_email, subscription: s).first
                if record.blank?
                  TTM::Mailer.with_synched_deliveries do
                    TTM::NotifierLog.create(email: s.notify_email, previous: Time.now, subscription: s)
                    s.notify_email.split(',').map(&:strip).each do |a|
                    TTM::Mailer.notify(a,s).deliver
                    end
                  end
                elsif (Time.now.beginning_of_day - record.previous.beginning_of_day) >= Setting.plugin_ttm['ttm_notify_period'].to_i.days
                  record.update(previous: Time.now)
                  TTM::Mailer.with_synched_deliveries do
                    s.notify_email.split(',').map(&:strip).each do |a|
                      TTM::Mailer.notify(a,s).deliver
                    end
                  end
                end
              end

						end

					end
       end

		end
	end
end
