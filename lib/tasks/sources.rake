namespace :sources do
  desc "Update all sources."
  task :update => :environment do
    Crawler.notify
  end
end
