class TagsController < ApplicationController

	def index
		@tags = Tag.all.limit(20)
	end
end
