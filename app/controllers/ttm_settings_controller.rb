class TtmSettingsController < ApplicationController
  unloadable
  menu_item :ttm_settings

  layout 'admin'
  before_filter :require_admin

  def index
    @subscriptions = TTM::Subscription.all
  end

  def save
    Setting.send "plugin_ttm=", params[:settings]
    redirect_to '/ttm_settings', notice: t('notice.settings.saved')
  end

end
