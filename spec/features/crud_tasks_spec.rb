require 'rails_helper'

describe 'Users can CRUD tasks' do

  before :each do
    visit "/tasks"
    expect(page).to have_content 'Due On'
  end

  it "user can create task" do

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
