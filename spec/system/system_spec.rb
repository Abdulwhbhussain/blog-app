# Go to db/seeds.rb
# To seed the database, Run rails db:seed RAILS_ENV=test
# To run the test, run rspec spec/system/system_spec.rb

# To run Feature tests, run rspec spec/views/

# System Spec for Blog App
require 'rails_helper'

RSpec.describe 'Whole System Test', type: :system do
  describe 'Users' do
    it 'Shows all users' do
      visit users_path
      sleep(5)
      expect(page).to have_content 'Shahadat Hossain'
      expect(page).to have_content 'Rakibul Islam'
    end

    it 'Shows the profile picture of each user' do
      visit users_path
      sleep(5)
      expect(page).to have_selector("img[src*='https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640']")
      expect(page).to have_selector("img[src*='https://images.unsplash.com/photo-1530268729831-4b0b9e170218?&fit=crop&w=640']")
    end

    it 'Shows the number of posts of each user' do
      visit users_path
      sleep(5)
      expect(page).to have_content 'Number of posts: 2'
      expect(page).to have_content 'Number of posts: 0'
    end

    it 'Redirects to that user page' do
      visit users_path
      sleep(5)
      link = find("a[href='#{user_path(User.first)}']")
      link.click
      sleep(5)
      expect(page).to have_current_path(user_path(User.first))
    end

    it 'Shows the user name' do
      visit user_path(User.first)
      sleep(5)
      expect(page).to have_content 'Shahadat Hossain'
    end

    it 'Shows the user profile picture' do
      visit user_path(User.first)
      sleep(5)
      expect(page).to have_selector("img[src*='https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640']")
    end

    it 'Shows the user bio' do
      visit user_path(User.first)
      sleep(5)
      expect(page).to have_content 'A skilled carpenter with over 15 years of experience, specializing in custom furniture design and installation.'
    end

    it 'Shows the number of posts of that user' do
      visit user_path(User.first)
      sleep(5)
      expect(page).to have_content 'Number of posts: 4'
    end

    it 'Shows the post title' do
      visit user_post_path(Post.first.author, Post.first)
      sleep(5)
      expect(page).to have_content 'First seed post'
    end

    it 'Shows the post text' do
      visit user_post_path(Post.first.author, Post.first)
      sleep(5)
      expect(page).to have_content 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'
    end

    it 'Shows the post author' do
      visit user_post_path(Post.first.author, Post.first)
      sleep(5)
      expect(page).to have_content 'Shahadat Hossain'
    end

    it 'Shows the number of comments of that post' do
      visit user_post_path(Post.first.author, Post.first)
      sleep(5)
      expect(page).to have_content 'Comments: 6'
    end

    it 'Shows the comment author' do
      visit user_post_path(Post.first.author, Post.first)
      sleep(5)
      expect(page).to have_content 'Rakibul Islam'
    end

    it 'Shows the comment text' do
      visit user_post_path(Post.first.author, Post.first)
      sleep(5)
      expect(page).to have_content 'Suspendisse at magna elit.'
    end

    it 'Shows the number of likes of that post' do
      visit user_post_path(Post.first.author, Post.first)
      sleep(5)
      expect(page).to have_content 'Likes: 5'
    end
  end
end
