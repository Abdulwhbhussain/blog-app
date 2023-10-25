class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :text, presence: true, length: { maximum: 5000 }

  after_create :increment_no_of_comments

  private

  def increment_no_of_comments
    post.increment!(:comments_counter)
  end
end
