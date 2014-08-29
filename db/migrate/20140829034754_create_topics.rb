class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :content
      t.references :user, index: true
      t.references :group, index: true

      t.timestamps
    end
  end
end
