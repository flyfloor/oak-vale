class AddDeafultValueToLikecount < ActiveRecord::Migration
  def change
  	change_table :posts do |t|
  		change_column_default(:posts, :like_count, 0)
  	end
  end
end
