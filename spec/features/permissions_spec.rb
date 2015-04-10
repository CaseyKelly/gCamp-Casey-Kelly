require 'rails_helper'

describe 'different users have different permissions' do

  before :each do
    @user = User.create(first_name: 'Test', last_name: 'User', email:'test@user.com', password: 'password', password_confirmation: 'password')
    visit '/login'
    fill_in "Email", with: 'test@user.com'
    fill_in "Password", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'Welcome back, stranger!'
  end

  it 'user login redirects to projects index' do
    expect(page).to have_content 'Create Project'
  end

  it 'new users are taken to new project page after signing up' do
    visit '/signup'
    fill_in "First name", with: 'New'
    fill_in "Last name", with: 'User'
    fill_in "Email", with: 'new@user.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_on 'Login!'
    expect(page).to have_content 'New Project'
  end

  it 'user is added as owner of events it creates' do
    visit '/projects/new'
    fill_in('Name', with: 'Another Dope Project')
    click_button 'Create Project'
    expect(page).to have_content 'Project was successfully created.'
    first(:link, 'Another Dope Project').click
    click_link 'Membership'
    expect(page).to have_css '.edit_membership'
  end

  it 'user creates project and is taken to project tasks page' do
    visit '/projects/new'
    fill_in('Name', with: 'A Sweet Project')
    click_button 'Create Project'
    expect(page).to have_content 'Project was successfully created.'
    expect(page).to have_content 'Tasks for A Sweet Project'
  end

  it 'user can only see projects it has created on project index' do
    @project = Project.create(name: 'Not my project')
    visit '/projects'
    expect(page).not_to have_content 'Not my project'
  end

  it 'user restricted from views of projects it doesnt belong to' do
    @project = Project.create(name: 'Not my project')
    visit project_path(@project)
    expect(page).to have_content 'You do not have access to that project.'
  end

  it 'user restricted from tasks of projects it doesnt belong to' do
    @project = Project.create(name: 'Not my project')
    visit project_tasks_path(@project)
    expect(page).to have_content 'You do not have access to that project.'
  end

  it 'user restricted from memberships of projects it doesnt belong to' do
    @project = Project.create(name: 'Not my project')
    visit project_memberships_path(@project)
    expect(page).to have_content 'You do not have access to that project.'
  end

  it 'only project owners can see edit button and delete well' do
    visit '/projects/new'
    fill_in 'Name', with: 'edit and delete permissions'
    click_button 'Create Project'
    visit '/projects'
    first(:link, 'edit and delete permissions').click
    expect(page).to have_css '.well'
    expect(page).to have_css '.btn-info'
    click_on 'Membership'
    within(:html, "p") do
      select('Member', :from => 'membership[role]')
      click_button 'Update'
    end
    expect(page).to have_content 'was successfully updated.'
    first(:link, 'edit and delete permissions').click
    expect(page).not_to have_css '.well'
    expect(page).not_to have_css '.btn-info'
  end

end
