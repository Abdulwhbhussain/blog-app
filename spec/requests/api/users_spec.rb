require 'swagger_helper'

RSpec.describe 'Blogs API', type: :request do

  path '/api/v1/users/sign_in' do
      
      # post 'Creates a user' do
      #   tags 'Users'
      #   consumes 'application/json'
      #   parameter name: :user, in: :body, schema: {
      #     type: :object,
      #     properties: {
      #       name: { type: :string },
      #       email: { type: :string },
      #       password: { type: :string },
      #       password_confirmation: { type: :string },
      #       photo: { type: :string },
      #       bio: { type: :string }
      #     },
      #     required: [ 'name', 'email', 'password', 'password_confirmation' ]
      #   }
  
      #   response '201', 'user created' do
      #     let(:user) { { name: 'foo', email: 'foo@gmail.com', password: '123456', password_confirmation: '123456' } }
      #     run_test!
      #   end
      # end

      post 'Login a user' do
        tags 'Users'
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string }
          },
          required: [ 'email', 'password' ]
        }
  
        response '200', 'user logged in' do
          let(:user) { { email: 'abbas@gmail.com', password: 'youcan' } }
          run_test!
        end
      end
  end
end
