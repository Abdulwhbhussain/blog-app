# System Spec for Blog App
require 'rails_helper'

RSpec.describe 'Whole System Test', type: :system do
  describe 'Users' do
    it 'Shows all users' do
      visit users_path
      sleep(5)
      expect(page).to have_content('Users')
    end
  end
end
