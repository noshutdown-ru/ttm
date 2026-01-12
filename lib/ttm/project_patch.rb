require 'project'
require_relative '../ttm'

module ProjectPatch
  def self.included(base)
    base.class_eval do
      has_many :subscriptions, class_name: 'TTM::Subscription'
    end
  end
end

Project.send(:include, ProjectPatch)
