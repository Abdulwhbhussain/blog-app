require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let!(:user) { User.create(name: 'John Doe', photo: 'https://via.placeholder.com/150', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget fermentum aliquam, quam nisl aliquet urna, nec aliquam nisl nunc quis nisl. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi. Nulla facilisi.') }

  describe 'GET #index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
    end

    it 'render correct index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include('users')
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'render correct show template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      get "/users/#{user.id}"
      expect(response.body).to include('given user')
    end
  end
end
