require 'rails_helper'

describe 'Users can CRUD memberships' do

  before :each do
    @user = User.create(first_name: 'Another', last_name: 'User', email: 'another@user.com', password: '123', password_confirmation: '123')
    visit '/signup'
    fill_in "First name", with: 'Test'
    fill_in "Last name", with: 'User'
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_on 'Login!'
    fill_in 'Name', with: 'A different test project'
    click_button 'Create Project'
    visit '/projects'
    first(:link, 'A different test project').click
  end

  it "user can create a membership" do
    click_on 'Membership'
    select 'Another User', :from => 'membership[user_id]'
    click_on "Add New Member"
    expect(page).to have_content 'Another User was successfully added.'
  end

  it 'user can edit a membership' do
    click_on 'Membership'
    select 'Another User', :from => 'membership[user_id]'
    click_on "Add New Member"
    expect(page).to have_content 'Another User was successfully added.'
    select 'Owner', :from => 'membership[role]', :match => :first
    first(:button, 'Update').click
    expect(page).to have_content 'Test User was successfully updated.'
  end

  it 'user can delete a membership' do
    click_on 'Membership'
    select 'Another User', :from => 'membership[user_id]'
    click_on "Add New Member"
    expect(page).to have_content 'Another User was successfully added.'
    page.first('.glyphicon.glyphicon-remove').click
  end

  it 'user can not create an invalid membership' do
    click_on 'Membership'
    click_on "Add New Member"
    expect(page).to have_content "User can't be blank"
  end

end
