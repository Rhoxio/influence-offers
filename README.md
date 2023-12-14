# Influence Offers

This is an app built to sllow Players to find Offers on mobile games

Ruby Version: `3.1.2`  
Rails Version: `7.1.2`

Gems:  
[Shakapacker](https://github.com/shakacode/shakapacker)  
[react_on_rails](https://www.shakacode.com/react-on-rails/docs/)  
[awesome_print](https://github.com/awesome-print/awesome_print)  
[activeadmin](https://activeadmin.info/index.html)  
[devise](https://github.com/heartcombo/devise)  
[sassc-rails](https://github.com/sass/sassc-rails)  
[pry](https://github.com/pry/pry)  
[faker](https://github.com/faker-ruby/faker)  
[factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)  
[rspec-rails](https://github.com/rspec/rspec-rails)  
[pg](https://github.com/ged/ruby-pg)
[shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
[database_cleaner-active_record](https://github.com/DatabaseCleaner/database_cleaner)
[foreman](https://rubygems.org/gems/foreman)


Database:
Postgresql

Setup:
 - Clone the repo down and run `cd influence_offers` to navigate into the project root.
 - run `bundle install` to install gems/dependencies
 - run `rails db:setup` to prepare the database and run migrations
 - run `rails db:seed` to add development data to the database
 - add `EXECJS_RUNTIME=Node` to your environment (for Shakapacker/React)
 - run `./bin/dev` to start the server with Shakapacker and `rails s`-type logging
 - navigate to `http://localhost:3000` in your browser to begin using the app

Running Tests:
- navigate to the root directory (`influence_offers`)
- run `rspec`
- (will probably need to add more instructions later, but that's how I run them for now)


Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
