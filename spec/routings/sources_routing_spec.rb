require 'spec_helper'

describe SourcesController do
  describe 'route for sources' do
    include Rails.application.routes.url_helpers
    it 'respond to url_for' do
      source = SourceFactory.new
      polymorphic_path(source).should eq '/sources'
    end
  end
end
