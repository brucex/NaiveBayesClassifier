module ApplicationHelper
	 # Sets current page's navigation bar to active
	 def is_active?(link_path)
	   current_page?(link_path) ? "active" : ""
	 end
end
