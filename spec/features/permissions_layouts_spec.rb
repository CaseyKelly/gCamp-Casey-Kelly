require 'rails_helper'

describe 'Different users see different layouts' do

  it 'marketing pages have old layout' do
    visit root_url
    expect(page).to have_css '.img-footer'
  end

end
