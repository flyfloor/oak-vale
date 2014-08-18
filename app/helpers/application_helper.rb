module ApplicationHelper

	def title page_title
	  return base_title unless page_title.present?
	  page_title
	end

	def base_title
	  'Oak Vale'
	end

	def timeago(time, options = {})
	  options[:class] ||= "timeago"
	  content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
	end

end
