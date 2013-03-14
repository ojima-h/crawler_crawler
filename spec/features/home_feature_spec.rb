require 'spec_helper'

feature 'Home' do
  scenario 'Visit crawler_crawler' do
    signin
    visit '/'
    # page.should have_content 'foo'
  end
end

