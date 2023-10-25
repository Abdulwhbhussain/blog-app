require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:first_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:first_post) { Post.create(author: first_user, title: 'Hello', text: 'This is my first post') }
  subject { described_class.new(user: first_user, post: first_post) }

  before { subject.save }

  # Validation tests
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'validates the presence of user' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'validates the presence of post' do
      subject.post = nil
      expect(subject).to_not be_valid
    end
  end

  # Method tests
  describe 'Methods' do
    it 'Returns Number of Likes on a Post' do
      expect(subject.post.likes_counter).to eq(1)
    end
  end
end
