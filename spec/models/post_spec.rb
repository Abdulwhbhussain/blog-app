require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', photo: 'https', bio: 'Macho Man!') }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(5000) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'callbacks' do
    describe 'after_create' do
      it 'increments the number of posts' do
        expect { Post.create(title: 'Test Post', text: 'This is a test post', author: user) }.to change { user.posts.count }.by(1)
      end
    end
  end

  describe 'methods' do
    describe '#recent_5_comments' do
      let(:post) { Post.create(title: 'Test Post', text: 'This is a test post', author: user) }

      it 'returns the 5 most recent comments on the post' do
        comment1 = Comment.create(text: 'This is the first comment', post: post)
        comment2 = Comment.create(text: 'This is the second comment', post: post)
        comment3 = Comment.create(text: 'This is the third comment', post: post)
        comment4 = Comment.create(text: 'This is the fourth comment', post: post)
        comment5 = Comment.create(text: 'This is the fifth comment', post: post)
        comment6 = Comment.create(text: 'This is the sixth comment', post: post)

        expect(post.recent_5_comments).to eq([comment6, comment5, comment4, comment3, comment2])
      end
    end
  end
end
