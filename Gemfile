source "https://rubygems.org"

ruby "3.3.4"

gem "rails", "~> 7.1.3", ">= 7.1.3.4"

gem "puma", ">= 5.0"

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

# gem
gem 'mongoid', '~> 9.0', '>= 9.0.1'
gem 'dotenv-rails', groups: [:development, :test]
gem 'jwt', '~> 2.8', '>= 2.8.2'
gem 'rack-attack'
gem 'rack-cors', '~> 2.0', '>= 2.0.2'
gem 'bcrypt', '~> 3.1', '>= 3.1.20'
gem 'redis', '~> 5.3'
gem 'cloudinary', '~> 2.1', '>= 2.1.2'
gem 'omniauth-google-oauth2', '~> 1.1', '>= 1.1.3'
# end

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

