class ExtraTimesController < ApplicationController
  unloadable

  before_action :find_subscription_and_project

  before_action :authorize
  
  def new
    @extra_time = TTM::ExtraTime.new(subscription: @subscription)
  end

  def index
  end
  
  def edit
  end

  def show
  end

  def destroy
    @extra_time.delete
    redirect_to project_subscriptions_path(@project)
    flash[:notice] = t('notice.extra_times.delete.success')
  end


  def update
    respond_to do |format|
      if @extra_time.update_attributes(params[:ttm_extra_time])
         format.html { redirect_to project_extra_times_path(@project), notice: t('notice.extra_time.update. success') }
       else
         format.html { render action: 'edit'}
       end
     end
  end

  def create
    @extra_time = TTM::ExtraTime.new(extra_time_params)
    @extra_time.subscription = @subscription
    respond_to do |format|
      if @extra_time.save
        format.html { redirect_to project_subscriptions_path(@project), notice: t('notice.extra_times.create.success') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
  def extra_time_params
    params.require(:ttm_extra_time).permit(:hours, :date_added)
  end

  #def find_extra_time
  #  @extra_time = TTM::Subscription.find(params[:id])
  #  unless @extra_time.project_id == @project.id
  #    redirect_to project_extra_times_path(@project), notice: t('notice.extra_time.not_found')
  #  end
  #end

  def find_subscription_and_project
    @subscription = TTM::Subscription.find(params[:subscription_id])
    @project = @subscription.project
  end

end
