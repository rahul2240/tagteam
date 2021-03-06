# frozen_string_literal: true
namespace :factory_girl do
  desc 'Verify that all FactoryGirl factories are valid'
  task lint: :environment do
    if Rails.env.test?
      begin
        DatabaseCleaner.start
        FactoryGirl.lint traits: true
      ensure
        DatabaseCleaner.clean_with(:truncation)
      end
    else
      system("bundle exec rake factory_girl:lint RAILS_ENV='test'")
    end
  end
end
