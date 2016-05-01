class AddIndexToModels < ActiveRecord::Migration
  def change
    add_index :comments, :submission_id, name: 'index_comments_on_submission_id'
    add_index :comments, :user_id, name: 'index_comments_on_user_id'
    add_index :replies, :comment_id, name: 'index_replies_on_comment_id'
    add_index :replies, :user_id, name: 'index_replies_on_user_id'
    add_index :submissions, :user_id, name: 'index_submissions_on_user_id'
  end
end
