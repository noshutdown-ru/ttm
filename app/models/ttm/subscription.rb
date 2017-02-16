module TTM

  class TTM::Subscription < ActiveRecord::Base
    has_many   :extra_times
    belongs_to :project
    belongs_to :user
    belongs_to :activity, :class_name => 'TimeEntryActivity'
    belongs_to :tracker
    unloadable
    attr_accessible :project_id, :user_id, :hours,
                    :activity_id, :begindate, :enddate,
                    :status, :rate, :tracker_id, :name,
                    :notify_email
    validates_numericality_of :rate, allow_nil: false
    validates_numericality_of :hours, allow_nil: false
    validates :project, presence: true
    validates :activity, presence: true
    validates :tracker, presence: true
    validates_associated :activity
    validate :only_one_subscription_on_period, :begindate_before_enddate

    #after_initialize do |s|
    #  s.calculate_spent
    #end
    def spent
      @spent ||= calculate_spent
      @spent.round(2)
    end

    def hours_with_extra
      @hours_with_extra ||= hours + extra_times.sum(:hours)
      @hours_with_extra
    end

    def left
      l = hours_with_extra - spent
      #l >= 0.0? l : 0.0
      l
    end
    
    def self.active(tracker_id=nil)
      subs = where("begindate <= :today AND enddate >= :today", {today: Date.today}).select { |x| x.status == 'active' || x.status == 'usedup' }
      subs = subs.select {|s| s.tracker_id == tracker_id } if tracker_id
      subs
    end

    def status
      return 'pending' if Date.today < begindate
      return 'closed' if Date.today > enddate
      return 'usedup' if spent >= hours_with_extra
      return 'active'
    end

    def find_time_entries(query_begin, query_end)
      cond = project.project_condition(Setting.display_subprojects_issues?)
      @time_entries = TimeEntry.visible.where(cond).where(activity: activity).where(spent_on: query_begin..query_end).includes(:issue)
    end

    def find_extra_times(query_begin, query_end)
      @extra_times = self.extra_times.where(date_added: query_begin..query_end)
    end

    def calculate_spent
      cond = project.project_condition(Setting.display_subprojects_issues?)
      TimeEntry.visible.where(cond).where(activity: activity).where(spent_on: begindate..enddate).sum(:hours).to_f
    end

    def only_one_subscription_on_period
      possible_overlaps = TTM::Subscription.where(project: project, activity: activity).where("begindate <= ? OR enddate >= ?", enddate, begindate)
      possible_overlaps = possible_overlaps.where("id != ?", id) if id
      possible_overlaps.each { |p|
        if ((p.begindate)..(p.enddate)).overlaps?(begindate..enddate)
          errors.add(:begindate, I18n.t('activerecord.models.subscription.errors.overlap'))
          errors.add(:enddate, I18n.t('activerecord.models.subscription.errors.overlap'))
          errors.add(:activity, I18n.t('activerecord.models.subscription.errors.overlap'))
          break
        end
      }
    end

    def begindate_before_enddate
      errors.add(:begindate, I18n.t('activerecord.models.subscription.errors.begindate')) if begindate > enddate
    end

  end
end
