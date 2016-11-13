module TTM

  class TTM::ExtraTime < ActiveRecord::Base
    belongs_to :subscription
    attr_accessible :hours, :date_added
    validates_numericality_of :hours, allow_nil: false
  end

end
