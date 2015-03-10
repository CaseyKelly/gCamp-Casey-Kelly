require 'rails_helper'

describe 'Users can CRUD memberships' do

  before :each do
    visit '/signup'
    fill_in "First name", with: 'Test'
    fill_in "Last name", with: 'User'
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_on 'Login!'
    @project = Project.create(name: 'Test project')
    visit '/projects'
    expect(page).to have_content 'Test project'
    click_on 'Test project'
  end

  it "user can create a membership" do
    click_on 'Memberships'
    select 'Test User', :from => 'membership[user_id]'
    click_on "Add New Member"
    expect(page).to have_content 'Test User was successfully added.'

  end

  it 'user can edit a membership' do
    click_on 'Memberships'
    select 'Test User', :from => 'membership[user_id]'
    click_on "Add New Member"
    expect(page).to have_content 'Test User was successfully added.'
    select 'Owner', :from => 'membership[role]', :match => :first
    click_on "Update"
    expect(page).to have_content 'Test User was successfully updated.'
  end

  it 'user can delete a membership' do
    click_on 'Memberships'
    select 'Test User', :from => 'membership[user_id]'
    click_on "Add New Member"
    expect(page).to have_content 'Test User was successfully added.'
    page.first('.glyphicon.glyphicon-remove').click
  end

  it 'user can not create an invalid membership' do
    click_on 'Memberships'
    click_on "Add New Member"
    expect(page).to have_content "User can't be blank"
  end

end
