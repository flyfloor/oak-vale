module ApplicationHelper

	def title page_title
	  return base_title unless page_title.present?
	  page_title
	end

	def base_title
	  'Oak Vale'
	end

end
