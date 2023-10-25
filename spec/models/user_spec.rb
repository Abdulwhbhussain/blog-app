require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_3_posts' do
    let(:user) { create(:user) }

    it 'returns the 3 most recent posts' do
      old_post = create(:post, author: user, created_at: 1.day.ago)
      new_post_1 = create(:post, author: user, created_at: 1.hour.ago)
      new_post_2 = create(:post, author: user, created_at: 30.minutes.ago)
      new_post_3 = create(:post, author: user, created_at: 5.minutes.ago)

      expect(user.recent_3_posts).to eq([new_post_3, new_post_2, new_post_1])
    end

    it 'returns less than 3 posts if the user has less than 3 posts' do
      old_post = create(:post, author: user, created_at: 1.day.ago)
      new_post_1 = create(:post, author: user, created_at: 1.hour.ago)

      expect(user.recent_3_posts).to eq([new_post_1, old_post])
    end

    it 'returns an empty array if the user has no posts' do
      expect(user.recent_3_posts).to eq([])
    end
  end
end
