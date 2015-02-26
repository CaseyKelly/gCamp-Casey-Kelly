require 'rails_helper'

describe 'Users can CRUD projects' do

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
  end

  it "user can create a project" do
    click_on 'Create Project'
    expect(page).to have_content 'Name'
    click_button "Create Project"
    expect(page).to have_content 'error prohibited this project from being saved'
    fill_in "Name", with: 'Big project'
    click_button "Create Project"
    expect(page).to have_content 'Project was successfully created.'
  end

  it 'user can edit a project' do
    click_on 'Edit'
    click_on 'Update Project'
    expect(page).to have_content 'Project was successfully updated.'
  end

  it 'user can delete a project' do
    click_on 'Delete'
    expect(page).to have_content 'Project was successfully deleted.'
  end

end
