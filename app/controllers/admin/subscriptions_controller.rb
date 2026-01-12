module Admin
  class SubscriptionsController < ApplicationController
    before_action :require_admin
    before_action :set_filters

    def index
      @subscriptions = TTM::Subscription.includes(:project, :activity, :tracker).order('projects.name, subscriptions.subscription_number')

      # Apply filters
      @subscriptions = @subscriptions.where(project_id: @project_id) if @project_id.present?
      @subscriptions = @subscriptions.where('subscriptions.subscription_number LIKE ?', "%#{@search}%") if @search.present?

      # Group by project
      @grouped_subscriptions = @subscriptions.group_by(&:project)
    end

    private

    def require_admin
      unless User.current.admin?
        render_403
      end
    end

    def set_filters
      @project_id = params[:project_id]
      @search = params[:search]
      @projects = Project.visible.order(:name)
    end
  end
end
