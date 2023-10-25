class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_no_of_comments

  private

  def increment_no_of_comments
    post.update(comments_counter: post.comments_counter + 1)
  end
end
