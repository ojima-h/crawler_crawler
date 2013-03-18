require 'spec_helper'

feature 'Sources' do
  scenario 'Create new source' do
    signin
    visit '/sources/new'

    fill_in 'source_name', with: 'test'
    click_button 'Save'

    visit '/sources/1/edit'
  end
end

