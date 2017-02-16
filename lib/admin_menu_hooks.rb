class AdminMenuHooks < Redmine::Hook::ViewListener
 def view_layouts_base_html_head(context = {})
	 stylesheet_link_tag('ttm.css', :plugin => 'ttm')
 end
end
