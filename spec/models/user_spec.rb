require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'John', photo: 'https://github.com/Abdulwhbhussain/blog-app/pull/3', bio: 'This is my history as a developer.') }

  before { subject.save }

  # Validation tests
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'validates the presence of posts_counter' do
      subject.posts_counter = nil
      expect(subject).to_not be_valid
    end

    it 'validates that posts counter is a positive integer' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  # Method tests
  describe 'Methods' do
    it 'Returns empty if the user has no posts' do
      expect(subject.recent_3_posts).to eq([])
    end

    it 'Returns 3 posts if the user has 3 posts recently' do
      first_post = subject.posts.create(title: 'Hello', text: 'This is my first post')
      second_post = subject.posts.create(title: 'Hello', text: 'This is my first post')
      third_post = subject.posts.create(title: 'Hello', text: 'This is my first post')
      expect(subject.recent_3_posts).to eq([third_post, second_post, first_post])
    end

    it 'Returns 3 posts if the user has 5 posts recently' do
      subject.posts.create(title: 'Hello', text: 'This is my first post')
      subject.posts.create(title: 'Hello', text: 'This is my first post')
      subject.posts.create(title: 'Hello', text: 'This is my first post')
      subject.posts.create(title: 'Hello', text: 'This is my first post')
      subject.posts.create(title: 'Hello', text: 'This is my first post')
      expect(subject.recent_3_posts.size).to eq(3)
    end

    it 'Returns 2 posts if the user has 2 posts recently' do
      first_post = subject.posts.create(title: 'Hello', text: 'This is my first post')
      second_post = subject.posts.create(title: 'Hello', text: 'This is my first post')
      expect(subject.recent_3_posts).to eq([second_post, first_post])
    end
  end
end
