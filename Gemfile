ruby File.read(File.expand_path(".ruby-version", __dir__)).chomp
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

#======
# CORE
#====
gem "mongoid", "~> 7.0.5"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.4"

#=======
# FRONT
#=====
gem "foundation-rails"
gem "jbuilder", "~> 2.7"
gem "sass-rails", ">= 6"
gem "slim", "~> 4.1"
gem "slim-rails", "~> 3.2"

#=========
# HELPERS
#=======
gem "autoprefixer-rails" # foundation  requirement
gem "bootsnap", ">= 1.4.2", require: false
gem "dotenv-rails"
gem "piper-rb", "~> 0.4"
gem "rails-healthcheck"

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop", "~> 1.28"
  gem "rubocop-rails", "~> 2.14"
  gem "rubocop-rspec"
end

group :development do
  gem "listen"
end

group :test do
  gem "benchmark-ips"
  gem "mongoid-rspec"
end
