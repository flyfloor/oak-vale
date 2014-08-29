class AddLikecountToTopics < ActiveRecord::Migration
  def change
  	add_column :topics, :like_count, :int, default: 0
  end
end
