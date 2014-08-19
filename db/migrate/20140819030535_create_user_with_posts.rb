class CreateUserWithPosts < ActiveRecord::Migration
  def change
    create_table :user_with_posts do |t|

      t.timestamps
    end
  end
end
