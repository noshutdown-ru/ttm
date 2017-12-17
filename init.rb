require_dependency 'project_patch'
require_dependency 'ttm_hook_listener'
#require "admin_menu_hooks"

Redmine::Plugin.register :ttm do
  name 'Time To Money'
  author 'noshutdown.ru'
  description 'Plugin for managing working time'
  version '0.2.1'
  url 'https://noshutdown.ru/redmine-plugins-ttm/'
  author_url 'https://noshutdown.ru/'

  project_module :subscriptions do
    permission :export_subscriptions, subscriptions: [ :subscriptions_to_pdf ]
    permission :view_subscriptions, subscriptions: [ :index, :show, :time_entries ]
    permission :edit_subscriptions, subscriptions: [ :create, :new, :edit, :update, :destroy ], extra_times: [ :create, :new, :index ]
  end

  menu :project_menu, :subscriptions, { controller: 'subscriptions', action: 'index' }, caption: Proc.new {I18n.t('activerecord.models.subscriptions')}, after: :activity, param: :project_id
  menu :admin_menu, :ttm, {:controller => 'ttm_settings', :action => 'index'}, :caption => Proc.new {I18n.t('label_ttm')}
  settings :default => {
               'empty' => true,
               'ttm_hours_to_warning' => 3.0,
               'ttm_currency' => '$',
               'ttm_notify_period' => '7'
           },
           :partial => 'settings/ttm_settings'

end