require 'rails_helper'

describe 'Users can CRUD users' do

  before :each do
    @user = User.create(first_name: 'Johnny', last_name: 'Cash', email: 'johnny@cash.com')
    visit '/users'
    expect(page).to have_content 'Johnny Cash'
  end

  it "user can create a user" do
    click_on 'New User'
    expect(page).to have_content 'First name'
    click_button "Create User"
    expect(page).to have_content 'errors prohibited this user from being saved'
    fill_in "First name", with: 'Casey'
    fill_in "Last name", with: 'Kelly'
    fill_in "Email", with: 'casey@kelly.com'
    click_button "Create User"
    expect(page).to have_content 'User was successfully created.'
  end

  it 'user can edit a user' do
    visit "/users"
    click_on 'Edit'
    click_on 'Update User'
    expect(page).to have_content 'User was successfully updated.'
  end

  it 'user can delete a user' do
    visit "/users"
    click_on 'Delete'
    expect(page).to have_content 'User was successfully deleted.'
  end

end
