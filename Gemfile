source "https://rubygems.org"

gem "rails", "4.2.5"
gem "pg", "~> 0.15"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "jquery-rails"
gem "faraday"

group :development, :test do
  gem "capybara"
  gem "dotenv-rails"
  gem "jazz_hands",
    github: "nixme/jazz_hands",
    branch: "bring-your-own-debugger"
  gem "rspec-rails"
  gem "spring"
  gem "spring-commands-rspec"
  gem "selenium-webdriver"
end

group :test do
  gem "shoulda-matchers", "< 3.0.0", require: false
end

