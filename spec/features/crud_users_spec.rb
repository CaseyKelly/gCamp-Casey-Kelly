require 'rails_helper'

describe 'Users can CRUD users' do

  before :each do
    @user = User.create(first_name: 'Johnny', last_name: 'Cash', email: 'johnny@cash.com', password: 'password')
    visit root_url
    click_on 'Sign In'
    fill_in "Email", with: 'johnny@cash.com'
    fill_in 'Password', with: 'password'
    click_on 'Login!'
    visit '/users'
    expect(page).to have_content 'Johnny Cash'
  end

  it "user can create a user" do
    click_on 'New User'
    expect(page).to have_content 'First name'
    click_button "Login!"
    expect(page).to have_content "Password can't be blank"
    fill_in "First name", with: 'Casey'
    fill_in "Last name", with: 'Kelly'
    fill_in "Email", with: 'casey@kelly.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Login!"
    expect(page).to have_content 'Thanks for signing up, dude!'
  end

  # it 'user can edit a user' do
  #   visit "/users"
  #   click_on 'Edit'
  #   click_on 'Update User'
  #   expect(page).to have_content 'User was successfully updated.'
  # end

  it 'user can delete a user' do
    visit "/users"
    click_on 'Delete'
    expect(page).to have_content 'You must be logged in to visit that page.'
  end

end
