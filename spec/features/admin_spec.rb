require 'rails_helper'

describe 'different users have different permissions' do

  before :each do
  end

  it 'there is an admin checkbox on new page for admin users' do
    @user = User.create(first_name: 'Joe', last_name: 'Admin', email: 'joe@admin.com', password: '123', password_confirmation: '123', admin: true)
    visit '/login'
    fill_in "Email", with: 'joe@admin.com'
    fill_in "Password", with: '123'
    click_on 'Login!'
    expect(page).to have_content 'Welcome back, stranger!'
    visit '/users'
    click_on 'New User'
    expect(page).to have_content 'Admin'
  end
  
end
