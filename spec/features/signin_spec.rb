require 'rails_helper'

describe 'Users can sign in and invalid users cannot' do

  before :each do
    @user = User.create(first_name: 'Test', last_name: 'User', email:'test@user.com', password: 'password', password_confirmation: 'password')
    visit '/login'
  end

  it "valid user can sign up" do
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'Welcome back, stranger!'
  end

  it "invalid user cannot sign up" do
    click_on 'Login!'
    expect(page).to have_content "Username / password combination is invalid"
  end

end
