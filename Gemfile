source 'https://rubygems.org'

gem 'rails',                   '4.2.2'

#rails g private_pub install
#rake up private_pub.ru -s thin -E production

gem 'private_pub'
gem 'faye'
gem 'thin'
gem 'config'
gem 'pg_search'
gem 'kaminari'

#foreman start

gem 'foreman'
gem 'redis-session-store'
gem 'redis-rails'

#gem 'activerecord-session_store'

gem 'bootstrap-will_paginate', '0.0.10'
gem 'bcrypt',                  '3.1.7'
gem 'faker',                   '1.4.2'
gem 'carrierwave',             '0.10.0'
gem 'mini_magick',             '3.8.0'
gem 'fog',                     '1.36.0'
gem 'will_paginate',           '3.0.7'
gem 'bootstrap-sass',          '3.2.0.2'
gem 'sass-rails',              '5.0.2'
gem 'uglifier',                '2.5.3'
gem 'coffee-rails',            '4.1.0'
gem 'jquery-rails',            '4.0.3'
gem 'turbolinks',              '2.3.0'
gem 'jbuilder',                '2.2.3'
gem 'sdoc',                    '0.4.0', group: :doc

gem 'sqlite3', group: :test
gem 'pg',             '0.17.1'
gem 'puma',           '3.1.0'


group :development, :test do
  
  gem 'byebug',      '3.4.0'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring',      '1.7.1'
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'peek'
  gem 'better_errors'
  gem 'bullet'

end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace'
  gem 'guard-minitest',     '2.3.1'
  gem 'database_cleaner'
  gem 'minitest-around'
#  gem 'minitest-rails-capybara'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end

