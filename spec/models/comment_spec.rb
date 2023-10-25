require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(5000) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'callbacks' do
    describe 'after_create' do
      it 'should increment the number of comments on the post' do
        post = create(:post)
        expect {
          create(:comment, post: post)
        }.to change { post.reload.comments_count }.by(1)
      end
    end
  end
end
