require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id).with_message('user can only like a post once') }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'callbacks' do
    describe 'after_create' do
      let(:user) { create(:user) }
      let(:post) { create(:post) }
      let(:like) { create(:like, user: user, post: post) }

      it 'should increment the number of likes for the post' do
        expect { like }.to change { post.reload.likes_count }.by(1)
      end
    end
  end
end
