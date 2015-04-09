require 'rails_helper'

describe 'different users have different permissions' do

  before :each do
    @user = User.create(first_name: 'Test', last_name: 'User', email:'test@user.com', password: 'password', password_confirmation: 'password')
    visit '/login'
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'Welcome back, stranger!'
  end

  it 'user login redirects to projects index' do
    expect(page).to have_content 'Create Project'
  end

  it 'new users are taken to new project page after signing up' do
    visit '/signup'
    fill_in "First name", with: 'New'
    fill_in "Last name", with: 'User'
    fill_in "Email", with: 'new@user.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'New Project'
  end

end
