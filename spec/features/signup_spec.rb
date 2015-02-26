require 'rails_helper'

describe 'Users can signup and invalid users cannot' do

  before :each do
    visit '/signup'
  end

  it "valid user can sign up" do
    fill_in "First name", with: 'Test'
    fill_in "Last name", with: 'User'
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'Thanks for signing up, dude!'
  end

  it "invalid user cannot sign up" do
    click_on 'Login!'
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
  end

end

# visit '/signup'
# fill_in "First name", with: 'Test'
# fill_in "Last name", with: 'User'
# fill_in "Email", with: 'test@user.com'
# fill_in "Password", with: 'password'
# fill_in "Password confirmation", with: 'password'
# click_on 'Login!'
# @project = Project.create(name: 'Test project')
# visit '/projects'
# expect(page).to have_content 'Test project'
