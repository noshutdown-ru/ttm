require_relative 'lib/ttm/project_patch'
require_relative 'lib/ttm/ttm_hook_listener'
#require "admin_menu_hooks"

Redmine::Plugin.register :ttm do
  name 'Time To Money'
  author 'noshutdown.ru'
  description 'Plugin for managing working time'
  version '1.0.0'
  url 'https://noshutdown.ru/redmine-plugins-ttm/'
  author_url 'https://noshutdown.ru/'

  permission :view_all_subscriptions, subscriptions: [ :all ]

  project_module :subscriptions do
    permission :export_subscriptions, subscriptions: [ :subscriptions_to_pdf ]
    permission :view_subscriptions, subscriptions: [ :index, :show, :time_entries ]
    permission :edit_subscriptions, subscriptions: [ :create, :new, :edit, :update, :destroy ], extra_times: [ :create, :new, :index ]
  end

  menu :top_menu, :ttm_subscriptions, { controller: 'subscriptions', action: 'all' }, caption: Proc.new {I18n.t('admin.ttm.subscriptions.title')}, :if => Proc.new {User.current.allowed_to?({:controller => 'subscriptions', :action => 'all'}, nil, :global => true)}
  menu :admin_menu, :ttm_subscriptions, { controller: 'settings', action: 'plugin', id: 'ttm' }, caption: Proc.new {"🕐 " + I18n.t('admin.ttm.subscriptions.title')}
  menu :project_menu, :subscriptions, { controller: 'subscriptions', action: 'index' }, caption: Proc.new {I18n.t('activerecord.models.subscriptions')}, after: :activity, param: :project_id

  settings :default => {
               'empty' => true,
               'ttm_hours_to_warning' => 3.0,
               'ttm_currency' => '$',
               'ttm_notify_period' => '7'
           },
           :partial => 'settings/ttm_settings'

end
