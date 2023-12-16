# Influence Offers

This is an app built to allow Players to find Offers on mobile games

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
 - Install [Node](https://nodejs.org/en/download)
  - You can check which node version you are running by running: `node -v` 
  - More recent versions work just fine. My version is: `v18.16.0`
 - Clone the repo down using: `git clone git@github.com:Rhoxio/influence-offers.git`
 - run `cd influence_offers` to navigate into the project root.
 - Ensure you have Ruby version `3.1.2` installed and active by running `ruby -v`.
  - `rvm` or `rbenv` commands might be required depending on your local environment
  - [rvm docs](https://rvm.io/rvm/cli)
  - [rbenv docs](https://github.com/rbenv/rbenv)
  - A `.ruby-version` file exists in the project, so it has the correct reference for version management tools
 - run `bundle install` to install gems/dependencies
 - run `rails db:setup` to prepare the database and run migrations
 - Check that Foreman is installed by running `gem list -i "^foreman$"` if it returns `true`, you are good to go.
   - If it doesn't return true, run `gem install foreman`. It's included in the `Gemfile`, but this is an extra precaution to check since Shakapacker uses it to watch for changes in `RAILS_ENV=development`.
 - run `rails db:seed` to add development data to the database
 - add `EXECJS_RUNTIME=Node` to your environment (for Shakapacker/React)
  - You can use `export EXECJS_RUNTIME=Node` temporarily unless you want to edit your shell profile. Just be aware that if you open a new shell, this will be un-set.
 - run `./bin/dev` to start the server with Shakapacker (This runs a `rails s` command - you'll see the output for both Shakapacker and Rails)
 - navigate to `http://localhost:3000` in your browser to begin using the app

Running Tests:
- navigate to the root directory (`./influence_offers`)
- run `rspec`
- (will probably need to add more instructions later, but that's how I run them for now)

Reasonable Changes to Project Proposal:
  - Instead of a unique `user_name` field, the project uses `email`. This is based off of the assumption that collecting emails as contact information and added functionality like resetting passwords would be baseline in most apps like this.
    - If we strictly want `user_name` and NO `email` column, I would `remove_column: :players, :email` and change the Devise settings to use `user_name` for sessions instead. If I needed to, I would add validations on the `Player` model to `validates :user_name, presence: true` and `validates :user_name, unique: true`. Views would be amended as needed, and feature/unit/integration tests would be added/changed as necessary.
    - If the `user_name` column needs to be ADDED to the `Player` modeling/schema, the same `:unique` and `:presence` validators would be used. I would `add_column: :players, :user_name, :string` to update the table and go from there. Views would be amended as needed, and feature/unit/integration tests would be added/changed as necessary.


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
