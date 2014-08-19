module ApplicationHelper

	def title page_title
		return page_title + " - #{base_title}"unless page_title.blank?
	  base_title
	end

	def base_title
	  'Oak Vale'
	end

	def timeago(time, options = {})
	  options[:class] ||= "timeago"
	  content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
	end

	def post_paginate_opt
		{page: params[:page], per_page: 5}
	end

	def user_paginate_opt
		{page: params[:page], per_page: 30}
	end

end
