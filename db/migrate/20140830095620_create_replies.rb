class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.references :user, index: true
      t.references :topic, index: true

      t.timestamps
    end
    remove_column :comments, :topic_id
  end
end
