ruby File.read(File.expand_path(".ruby-version", __dir__)).chomp
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

#======
# CORE
#====
# gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"

#=======
# FRONT
#=====
gem "jbuilder", "~> 2.7"
gem "sass-rails", ">= 6"

#=========
# HELPERS
#=======
gem "bootsnap", ">= 1.4.2", require: false

group :development, :test do
  gem "pry-rails"
  gem "rubocop"
end

group :development do
  gem "listen"
end
