require 'rails_helper'

describe 'Users can CRUD projects' do

  before :each do
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
    visit "/projects"
    click_on 'Edit'
    click_on 'Update Project'
    expect(page).to have_content 'Project was successfully updated.'
  end

  it 'user can delete a project' do

  end

end
