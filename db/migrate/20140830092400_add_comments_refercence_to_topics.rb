class AddCommentsRefercenceToTopics < ActiveRecord::Migration
  def change
  	add_column :comments, :topic_id, :int
  	add_index :comments, :topic_id
  end
end
