class SubscriptionsController < ApplicationController
  unloadable

  before_action :find_project_by_project_id
  before_action :authorize
  before_action :find_subscription, only: [:show, :update, :edit, :destroy, :time_entries]
  #before_action :find_subscriptions
  
  accept_api_auth :index, :show, :create, :update, :destroy, :time_entries
  
  def index

    @query = params[:query]

    if @query
      if params[:search_fild] == 'name'
        @subscriptions = @project.subscriptions.where('`name` LIKE ?', "%#{@query}%")
      end
    else
      @subscriptions = @project.subscriptions
    end

    respond_to do |format|
      format.html
      format.json { render json: @subscriptions }
      format.pdf
    end
  end
  
  def new
    @subscription = TTM::Subscription.new(project: @project, begindate: Date.today, enddate: Date.today + 1.month)
  end

  def edit
  end

  def show
    @query_begin = params["query_begin"]? Date.parse(params["query_begin"]) : Time.now.beginning_of_month.to_date
    @query_end = params["query_end"]? Date.parse(params["query_end"]) : Date.today
    @query_begin = @subscription.begindate.to_date if @query_begin < @subscription.begindate
    @query_end = @subscription.enddate.to_date if @query_end > @subscription.enddate
    @time_entries = @subscription.find_time_entries(@query_begin, @query_end)
    @extra_times = @subscription.find_extra_times(@query_begin, @query_end)
    @total_time = @time_entries.inject(0.0) do |total, te|
          total += te.hours
    end
    @total_cost = @total_time * @subscription.rate
    respond_to do |format|
      format.html
      format.json { render json: @subscription }
    end
  end

  def time_entries
    @query_begin = params["query_begin"]? Date.parse(params["query_begin"]) : Time.now.beginning_of_month.to_date
    @query_end = params["query_end"]? Date.parse(params["query_end"]) : Date.today
    @query_begin = @subscription.begindate.to_date if @query_begin < @subscription.begindate
    @query_end = @subscription.enddate.to_date if @query_end > @subscription.enddate
    @time_entries = @subscription.find_time_entries(@query_begin, @query_end)
    respond_to do |format|
      format.json { render json: @time_entries }
    end
  end

  def destroy
    respond_to do |format|
      if @subscription.delete 
        format.html { redirect_to project_subscriptions_path(@project), notice: t('notice.subscriptions.delete.success') }
        format.json { render text: '', status: :accepted, layout: nil }
      else
        format.html { redirect_to project_subscriptions_path(@project) }
        format.json { render text: '', status: :bad_request, layout: nil }
      end
    end
  end


  def update
    respond_to do |format|
      if @subscription.update_attributes(params[:ttm_subscription])
         format.html { redirect_to project_subscriptions_path(@project), notice: t('notice.subscriptions.update.success') }
         format.json { render text: '', status: :accepted, layout: nil }
       else
         format.html { render action: 'edit'}
         format.json { render text: '', status: :bad_request, layout: nil }
       end
     end
  end

  def create
    @subscription = TTM::Subscription.new(subscription_params)
    @subscription.project = @project
    respond_to do |format|
      if @subscription.save
        format.html { redirect_to project_subscriptions_path(@project), notice: t('notice.subscriptions.create.success') }
        format.json { render text: '', status: :created, layout: nil }
      else
        format.html { render action: 'new' }
        format.json { render text: '', status: :bad_request, layout: nil }
      end
    end
  end

  private
  #def find_subscriptions
  #end
  def subscription_params
    params.require(:ttm_subscription).permit(:hours, :activity_id, :tracker_id, :begindate, :enddate, :rate, :name, :notify_email)
  end

  def find_subscription
    @subscription = TTM::Subscription.find(params[:id])
    unless @subscription.project_id == @project.id
      redirect_to project_subscriptions_path(@project), notice: t('notice.subscriptions.not_found')
    end
  end

end
