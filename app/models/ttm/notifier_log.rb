module TTM

  class NotifierLog < ActiveRecord::Base
    belongs_to :subscription
    attr_accessible :email, :previous, :subscription
  end

end
