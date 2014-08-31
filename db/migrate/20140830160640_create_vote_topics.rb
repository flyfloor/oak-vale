class CreateVoteTopics < ActiveRecord::Migration
  def change
    create_table :vote_topics do |t|
  		t.integer :user_id
  	  t.integer :topic_id

      t.timestamps
    end

    add_index :vote_topics, :user_id
    add_index :vote_topics, :topic_id
    add_index :vote_topics, [:user_id, :topic_id], unique: true
  end
end
