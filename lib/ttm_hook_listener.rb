class TTMHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_sidebar_issues_bottom, partial: 'subscriptions/active'
  render_on :view_projects_show_sidebar_bottom, partial: 'subscriptions/active'
  render_on :view_layouts_base_html_head, partial: 'ttm/stylesheets'
  #def view_issues_sidebar_issues_bottom(context = {})
  #  return content_tag("p", "There will be a table" + context[:project].subscriptions.to_s)
  #end
end
