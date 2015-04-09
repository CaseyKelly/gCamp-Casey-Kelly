require 'rails_helper'

describe 'Different users see different layouts' do

  before :each do
    visit root_url
  end

  it 'marketing pages have old layout' do
    expect(page).to have_css '.img-footer'
  end

  it 'gCamp navbar brand links to projects on internal pages' do
    @user = User.create(first_name: 'Test', last_name: 'User', email:'test@user.com', password: 'password', password_confirmation: 'password')
    visit '/login'
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'Welcome back, stranger!'
    click_link 'gCamp'
    expect(page).to have_content 'Create Project'
  end

end
