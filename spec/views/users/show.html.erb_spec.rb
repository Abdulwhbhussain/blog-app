require 'rails_helper'
RSpec.describe 'users/show.html.erb', type: :feature do
  before(:each) do
    @author = User.create(name: 'Shahadat Hossain',
                          photo: 'https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640',
                          bio: 'A skilled carpenter with over 15 years of experience, specializing ine.')
    @user = User.create(name: 'Rakibul Islam',
                        photo: 'https://images.unsplash.com/photo-1530268729831-4b0b9e170218?&fit=crop&w=640',
                        bio: 'A licensed therapist with expertise in cognitive-behavioral therapy and trauma-informed.')
    @post = Post.create(author: @author, title: 'First seed post', text: 'Lorem Ipsum is simple.')
    @post2 = Post.create(author: @author, title: 'Second seed post', text: 'Lorem Ipsum is simple2.')
    @post3 = Post.create(author: @author, title: 'Third seed post', text: 'Lorem Ipsum is simple3.')
    @comment = Comment.create(post: @post, user: @user, text: 'first comment')
    @comment2 = Comment.create(post: @post, user: @user, text: 'Sed auctor augue euismod est faucibus ultrices.')
    @comment3 = Comment.create(post: @post2, user: @user, text: 'Sed auctor augue euismod est faucibus ultrices.')
    @like = Like.create(post: @post, user: @user)
    visit user_path(@author)
  end

  context 'The Page Should contain' do

    it 'the user photo' do
      expect(page).to have_selector("img[src*='https://images.unsplash.com/photo-1651684215020-f7a5b6610f23?&fit=crop&w=640']")
    end

    it 'the user name' do
      expect(page).to have_content @author.name
    end

    it 'the number of posts the user has' do
      expect(page).to have_content @author.posts_counter
    end

    it 'the user bio' do
      expect(page).to have_content @author.bio
    end

    it 'the user 3 most recent posts' do
      expect(page).to have_content @post.title
      expect(page).to have_content @post2.title
      expect(page).to have_content @post3.title
    end

    it 'the button to see all the user posts' do
      expect(page).to have_link 'See all posts'
    end
  end

  context 'The Page Should redirect to' do
    it 'the post page when click on the post title' do
      link = find("a[href='#{user_post_path(@post.author, @post)}']")
      link.click
      expect(page).to have_current_path(user_post_path(@post.author, @post))
    end

    it 'the posts page when click on the See all posts button' do
      link = find("a[href='#{user_posts_path(@author)}']")
      link.click
      expect(page).to have_current_path(user_posts_path(@author))
    end
  end
end
