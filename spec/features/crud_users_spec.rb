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
    fill_in "First name", with: 'Casey'
    fill_in "Last name", with: 'Kelly'
    fill_in "Email", with: 'casey@kelly.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Login!"
    expect(page).to have_content 'Thanks for signing up, dude!'
  end

  it 'user can delete a user' do
    visit "/users"
    click_on 'Delete'
    expect(page).to have_content 'You must be logged in to visit that page.'
  end

  it 'user can not create a user without a first name' do
    click_on 'New User'
    fill_in "Last name", with: 'Kelly'
    fill_in "Email", with: 'casey@kelly.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Login!"
    expect(page).to have_content "First name can't be blank"
  end

  it 'user can not create a user without a last name' do
    click_on 'New User'
    fill_in "First name", with: 'Casey'
    fill_in "Email", with: 'casey@kelly.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Login!"
    expect(page).to have_content "Last name can't be blank"
  end

  it 'user can not create a user without a password' do
    click_on 'New User'
    fill_in "First name", with: 'Casey'
    fill_in "Last name", with: 'Kelly'
    fill_in "Email", with: 'casey@kelly.com'
    click_button "Login!"
    expect(page).to have_content "Password can't be blank"
  end

  it "user can not create a user if passwords do not match" do
    click_on 'New User'
    fill_in "First name", with: 'Casey'
    fill_in "Last name", with: 'Kelly'
    fill_in "Email", with: 'casey@kelly.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'pasword'
    click_button "Login!"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it 'user can not create a user without an email' do
    click_on 'New User'
    fill_in "First name", with: 'Casey'
    fill_in "Last name", with: 'Kelly'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Login!"
    expect(page).to have_content "Email can't be blank"
  end

  it 'user can not create a user if email is not unique' do
    click_on 'New User'
    fill_in "First name", with: 'Casey'
    fill_in "Last name", with: 'Kelly'
    fill_in "Email", with: 'casey@kelly.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Login!"
    expect(page).to have_content 'Thanks for signing up, dude!'
    click_on 'New User'
    fill_in "First name", with: 'Casey'
    fill_in "Last name", with: 'Kelly'
    fill_in "Email", with: 'casey@kelly.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_button "Login!"
    expect(page).to have_content 'Email has already been taken'
  end

end
