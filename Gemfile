ruby File.read(File.expand_path(".ruby-version", __dir__)).chomp
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

#======
# CORE
#====
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.2"

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
gem "piper-rb"

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop"
end

group :development do
  gem "listen"
end
