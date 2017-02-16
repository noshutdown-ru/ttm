module TTM

  class TTM::ExtraTime < ActiveRecord::Base
    belongs_to :subscription
    attr_accessible :hours, :date_added
    validates :subscription, presence: true
    validates_numericality_of :hours, allow_nil: false
    validates :hours, presence: true
    validates :date_added, presence: true
    validate :date_added_cant_be_after_susbsription_end_date
    validate :date_added_cant_be_before_susbsription_begin_date

    def date_added_cant_be_after_susbsription_end_date
      if date_added.present? and date_added > subscription.enddate
        errors.add :date_added, "can't be after subscription end date"
      end
    end

    def date_added_cant_be_before_susbsription_begin_date
      if date_added.present? and date_added < subscription.begindate
        errors.add :date_added, "can't be before subscription begin date"
      end
    end
  end

end
