require 'rails_helper'

describe 'Users can CRUD tasks' do

  before :each do
    visit '/signup'
    fill_in "First name", with: 'Charlie'
    fill_in "Last name", with: 'Bucket'
    fill_in "Email", with: 'charlie@user.com'
    fill_in "Password", with: 'password'
    fill_in "Password confirmation", with: 'password'
    click_on 'Login!'
    @project = Project.create(name: 'Test project')
    @task = Task.create(description: 'Task hard bro', due_date: '08-19-2015', complete: false)
    visit project_tasks_path(@project)
  end

  it "user can create task" do
    click_on 'New Task'
    expect(page).to have_content 'Description'
    fill_in "Description", with: 'Pass the test'
    click_button "Create Task"
    expect(page).to have_content 'Task was successfully created.'
    expect(page).to have_content 'Pass the test'
  end

  it 'user can edit a task' do
    click_on 'New Task'
    expect(page).to have_content 'Description'
    fill_in "Description", with: 'Pass the test'
    click_button "Create Task"
    expect(page).to have_content 'Task was successfully created.'
    expect(page).to have_content 'Pass the test'
    click_on 'Edit'
    click_on 'Update Task'
    expect(page).to have_content 'Task was successfully updated.'
  end

  it 'user can delete a task' do
    click_on 'New Task'
    expect(page).to have_content 'Description'
    fill_in "Description", with: 'Pass the test'
    click_button "Create Task"
    expect(page).to have_content 'Task was successfully created.'
    expect(page).to have_content 'Pass the test'
    find('.delete-button').click
    expect(page).to have_content 'Task was successfully destroyed.'
  end

  it 'user can not create an invalid task' do
    click_on 'New Task'
    click_button "Create Task"
    expect(page).to have_content "Description can't be blank"
  end

end
