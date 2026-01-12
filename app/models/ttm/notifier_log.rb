module TTM

  class NotifierLog < ActiveRecord::Base
    belongs_to :subscription, class_name: 'TTM::Subscription'
  end

end
