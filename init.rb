require_dependency 'project_patch'
require_dependency 'ttm_hook_listener'
#require "admin_menu_hooks"

Redmine::Plugin.register :ttm do
  name 'Time To Money'
  author 'noshutdown.ru'
  description 'Plugin for managing working time'
  version '0.1.3'
  url 'https://noshutdown.ru/redmine-plugins-ttm/'
  author_url 'https://noshutdown.ru/'

  project_module :subscriptions do
    permission :view_subscriptions, subscriptions: [ :index, :show ]
    permission :edit_subscriptions, subscriptions: [ :create, :new, :edit, :update, :destroy ], extra_times: [ :create, :new ]
  end

  menu :project_menu, :subscriptions, { controller: 'subscriptions', action: 'index' }, caption: Proc.new {I18n.t('activerecord.models.subscriptions')}, after: :activity, param: :project_id
  settings :default => {
               'empty' => true,
               'ttm_hours_to_warning' => 3.0,
               'ttm_currency' => '$',
               'ttm_notify_period' => '7' 
           },
           :partial => 'settings/ttm_settings'

end
