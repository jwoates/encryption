source :rubygems

# Server requirements (defaults to WEBrick)
# gem 'thin'
# gem 'mongrel'

# Project requirements
#gem 'rake', '0.8.7'
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

# Component requirements
gem 'fb_graph'
gem 'crypt'
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'erubis', "~> 2.7.0"
gem 'activerecord', :require => "active_record"
#gem 'newrelic_rpm'


# Extended requirements
gem 'rubyzip'
gem 'rmagick', :require => 'RMagick'

## groups
group :production do
  gem 'thin'
  #gem 'pg'
  gem "pg", "~> 0.11.0"

end
group :development do
  gem 'sqlite3'
end

# Test requirements
gem 'shoulda', :group => "test"
gem 'rack-test', :require => "rack/test", :group => "test"

# Padrino Stable Gem
gem 'padrino', '0.10.5'
