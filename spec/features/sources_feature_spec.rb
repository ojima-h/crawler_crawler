require 'spec_helper'

feature 'Sources' do
  scenario 'Create new source' do
    signin
    visit '/sources/new'

    fill_in 'source_name', with: 'test'
    select  'Test', from: 'source_crawler_strategy'
    fill_in 'source_params_Test_p', with: 1
    click_button 'Save'

    Crawler.last.name.should eq 'test'
    Crawler.last.params.should be_has_key :p
    Crawler.last.params[:p].should eq '1'

    visit '/sources/1/edit'
  end

  scenario 'Update a source' do
    signin

    @source = FactoryGirl.create :source_factory, user: current_user

    visit '/sources/1/edit'

    fill_in 'source_name', with: 'test_mod'
    select  'Test', from: 'source_crawler_strategy'
    fill_in 'source_params_Test_p', with: 2
    click_button 'Save'

    Crawler.last.name.should eq 'test_mod'
    Crawler.last.params.should be_has_key :p
    Crawler.last.params[:p].should eq '2'
  end
end

