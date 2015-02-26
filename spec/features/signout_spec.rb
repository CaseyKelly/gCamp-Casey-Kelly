require 'rails_helper'

describe 'Signed-in users can sign out' do

  before :each do
    @user = User.create(first_name: 'Test', last_name: 'User', email:'test@user.com', password: 'password', password_confirmation: 'password')
    visit '/login'
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'Welcome back, stranger!'
  end

  it "user can sign out" do
    click_on 'Sign Out'
    expect(page).to have_content "We're sorry to see you go!"
  end

end
