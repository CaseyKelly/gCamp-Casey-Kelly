require 'rails_helper'

describe 'Different users see different layouts' do

  before :each do
    @user = User.create(first_name: 'Test', last_name: 'User', email:'test@user.com', password: 'password', password_confirmation: 'password')
    visit '/login'
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'Welcome back, stranger!'
    visit root_url
  end

  it 'marketing pages have old layout' do
    expect(page).to have_css '.img-footer'
  end

  it 'gCamp navbar brand links to projects on internal pages' do
    click_link 'gCamp'
    expect(page).to have_content 'Create Project'
  end

  it 'dropdown shows projects the current user belongs to' do
    visit 'projects/new'
    fill_in('Name', with: 'Dope Project')
    click_button 'Create Project'
    expect(page).to have_content 'Project was successfully created.'
    click_on 'projects-dropdown'
    expect(page).to have_css '.dropdown-menu li a'
  end

end
