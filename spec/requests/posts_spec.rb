require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let!(:user) { User.create(name: 'Abdul', photo: 'https://via.placeholder.com/155', bio: 'Brother to Everyone.') }

  let!(:post1) { user.posts.create(title: 'My first post', text: 'This is my first post on this blog.') }
  let!(:post2) { Post.create(author: user, title: 'My second post', text: 'This is my second post on this blog.') }
  let!(:post3) { Post.create(author: user, title: 'My third post', text: 'This is my third post on this blog.') }

  describe 'GET #index' do
    it 'returns http success' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end

    it 'render correct index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get "/users/#{user.id}/posts/#{post1.id}"
      expect(response).to have_http_status(:success)
    end

    it 'render correct show template' do
      get "/users/#{user.id}/posts/#{post1.id}"
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post1.id}"
      expect(response.body).to include('Here is a Given post for a given user')
    end
  end
end
