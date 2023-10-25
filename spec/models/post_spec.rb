require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { described_class.new(title: 'Hello world', text: 'This is my first post') }

  before { subject.save }

  # Validation tests
  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'validates the presence of title' do
      expect(subject).to validate_presence_of(:title)
    end

    it 'validates the presence of text' do
      expect(subject).to validate_presence_of(:text)
    end

    it 'validates the presence of comments_counter' do
      expect(subject).to eq(0)
    end

    it 'validates the presence of likes_counter' do
      expect(subject).to eq(0)
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a text' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'validates the presence of comments_counter' do
      subject.comments_counter = nil
      expect(subject).to_not be_valid
    end

    it 'validates the presence of likes_counter' do
      subject.likes_counter = nil
      expect(subject).to_not be_valid
    end

    it 'validates that comments counter is a positive integer' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'validates that likes counter is a positive integer' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  # Method tests
  describe 'Methods' do
    it 'Returns empty if the post has no comments' do
      expect(subject.recent_5_comments).to eq([])
    end
  end
  
end
