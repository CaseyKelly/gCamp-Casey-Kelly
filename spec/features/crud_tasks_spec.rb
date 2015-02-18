require 'rails_helper'

describe 'Users can CRUD tasks' do

  before :each do
    @task = Task.create(description: 'Task hard bro', due_date: '08-19-2015', complete: false)
    visit "/tasks"
    expect(page).to have_content 'Task hard bro'
  end

  it "user can create task" do
    click_on 'New Task'
    expect(page).to have_content 'Description'
    fill_in "Description", with: 'Pass the test'
    click_button "Create Task"
    expect(page).to have_content 'Task was successfully created.'
  end

  it 'user can edit a task' do
    visit "/tasks"
    click_on 'Edit'
    click_on 'Update Task'
    expect(page).to have_content 'Task was successfully updated.'
  end

  it 'user can delete a task' do
    visit "/tasks"
    click_on 'Delete'
    expect(page).to have_content 'Task was successfully destroyed.'
  end

end

# describe 'add a player' do
#
#   before :each do
#     @my_team = Team.create(name: 'pizza and the woofers')
#     visit "teams/#{@my_team.id}/players/new"
#   end
#
#   it "successfully adds a player" do
#     expect(page).to have_content @my_team.name
#   end
#
#   it "adds a player with a name" do
#     fill_in "Name", with: "Puggeroni"
#     click_button "Create Player"
#     expect(page).to have_content "Puggeroni"
#   end
#
# end
