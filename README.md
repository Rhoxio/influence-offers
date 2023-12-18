# Influence Offers

This is an app built to allow Players to find Offers on mobile games. It features a weighted suggestion system based on previous offers the Player has claimed as well as some base weights for Player age and gender.

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
`Postgresql`

## Setup:
 - Install [Node](https://nodejs.org/en/download)  
   - You can check which node version you are running by running: `node -v` 
   - More recent versions work just fine. My version is: `v18.16.0`
   - If you had to install Node, you'll need to reload your `.bash_profile` (or whatever you're using to load `PATH` variables) or reopen the shell.
 - Clone the repo down using: `git clone git@github.com:Rhoxio/influence-offers.git`
 - run `cd influence_offers` to navigate into the project root.
 - Ensure you have Ruby version `3.1.2` installed and active by running `ruby -v`.
   - `rvm` or `rbenv` commands might be required depending on your local environment
   - [rvm docs](https://rvm.io/rvm/cli)
   - [rbenv docs](https://github.com/rbenv/rbenv)
   - A `.ruby-version` file exists in the project, so it has the correct reference for version management tools
 - run `bundle install` to install gems/dependencies
 - Double-check that Foreman is installed by running `gem list -i "^foreman$"` if it returns `true`, you are good to go.
   - If it retuns `false`, run `gem install foreman`. It's included in the `Gemfile`, but this is an extra precaution to check since Shakapacker uses it to watch for changes in development mode.
 - run `yarn` to install JS dependencies
 - add `EXECJS_RUNTIME=Node` to your environment (for Shakapacker/React)
   - You can use `export EXECJS_RUNTIME=Node` temporarily unless you want to edit your shell/bash/zsh profile. Just be aware that if you open a new window, this will be un-set.
   - I noticed that my environment didn't seem to care if I had this set or not, but yours might.
 - run `rails db:setup` to prepare the database and run migrations
   - This should create the database, migrate, and seed the data. 
 - run `./bin/dev` to start the server with Shakapacker (This runs a `rails s` command - you'll see the output for both Shakapacker and Rails)
 - navigate to `http://localhost:3000` in your browser to begin using the app

Running Tests:
- run `rspec` in the project root

## My Thoughts:
Overall, the project was fun and interesting to build! I am used to dealing with larger scales of complexity and having to worry about future-proofing, so this was a nice respite from that. This also distanced from making vain attempts at predicting the future to design flexibility into the right parts of a system. If this app were to grow larger and actually integrate with external API services, I would definitely be able to make changes quickly as the build followed KISS principles and produced solid, working functionality without exploding scope on niceties and including too much functionality for the relative simplicity of the data modeling and UI. THings are by no means perfect, but I made an attempt to build the app with the 'right tool for the job' attitude while constantly questioning my previous assumptions. 

Of course I can add things like Sieqkiq and Redis for background processing, Opensearch for weighted queries, more nuanced abstrations to better evoke the potential of the data model and provide more explicit interfacing... the list goes on about the things I **COULD** do. This project was about setting a limit and doing the best I could within that scope, and I feel I was successful. I learned a lot about how I feel software should be written, and at the end of the day, how I can help others write better software and provide insights from direct experience versus the top three results on Google. One of the wonderful things about software is that every time you write something you are reinforcing something that you learned previously and teasing the nuance from it. You can write the same code twice in different contextx - but you express the same heirarchies of thought in different ways all the time!

### Technology Decisions
[Shakapacker](https://github.com/shakacode/shakapacker)  
[react_on_rails](https://www.shakacode.com/react-on-rails/docs/)  
I definitely wanted to use React, not only because it was listed as a 'Bonus', but because I have worked with it before and wanted to see where I was at with it since I have been leaning toward back-end and architecture more the past few years. React is arguably the most popular library for front end development, and I have liked working with it in the past. The features in the UI didn't lend itself to hacking away with vanilla JS - I needed a state management option. React just seemed like the natrual choice when cobining concerns from the requirements doc and my experience with building similar feature sets. I ended up going with Shakapacker and react_on_rails due to a previous setup not working currently with `react-rails` and Shakapacker. It was a major debugging session, and the pull request with details can be found [here](https://github.com/Rhoxio/influence-offers/pull/3).

[activeadmin](https://activeadmin.info/index.html)  
I wanted to have an admin tool so I could CRUD easily without having to run console commands or write and edit scripts. Activeadmin is a quick way to get this done and provides a nice UI for viewing data. It comes with the added bonus if allowing the Influence Mobile devs to tinker with things as well.

[devise](https://github.com/heartcombo/devise)
I mean... why not use Devise for sessions? I didn't want to write a bunch of boilerplate controllers/bcrypt password hashing/sessions/helper methods stuff manually. Seems perfectly reasonable. Devise is something that I have used for at least 6 years when working with Rails apps. It's widely used and is very customaizable with strong defaults, so it was the natural choice for an auth solution.

[pry](https://github.com/pry/pry)  
I like uing pry to help me debug issues. It's also nice to help you write tests without having to stare at reference files and try to follow the logic backward and forwards. "Is this variable set correctly? -checks it- Oh yeah, thats not right..." versus "Log this variable... rspec... ok its wrong. Try again." It just makes the development flow far better and saves me large amounts of time.

[faker](https://github.com/faker-ruby/faker)  
[factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)  
[rspec-rails](https://github.com/rspec/rspec-rails) 
[shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
[database_cleaner-active_record](https://github.com/DatabaseCleaner/database_cleaner)
Testing gems! Faker is nice because I don't have to write in boilerplate test data and think of unique names. FactoryBot is great because it provides me with a simple way to create and manage fixtures/test data. I prefer RSpec just because I enjoy the terse syntax more than something like Minitest. It's just a preference, but I've almost always chosen to use RSpec for testing Rails apps. shoulda-matchers is SUPER nice for writing unit tests - validations, db columns, and [assosciations can be tested using one-liners](https://thoughtbot.com/upcase/test-driven-rails-resources/shoulda_matchers.pdf). Less code for me to write and maintain - always a HUGE bonus! Databse cleaner just helps me keep the database clean when I go to run tests.

[pg](https://github.com/ged/ruby-pg)  
Using Rails with Postgres? You need it!

[foreman](https://rubygems.org/gems/foreman) 
Required for Shakapacker to work. 

### Reasonable Changes to Project Proposal:
  - Instead of a unique `user_name` field, the project uses `email`. This is based off of the assumption that collecting emails as contact information and added functionality like resetting passwords would be baseline in most apps like this.
    - If we strictly want `user_name` and NO `email` column, I would `remove_column: :players, :email` and change the Devise settings to use `user_name` for sessions instead. If I needed to, I would add validations on the `Player` model to `validates :user_name, presence: true` and `validates :user_name, unique: true`. Views would be amended as needed, and feature/unit/integration tests would be added/changed as necessary.
    - If the `user_name` column needs to be ADDED to the `Player` modeling/schema, the same `:unique` and `:presence` validators would be used. I would `add_column: :players, :user_name, :string` to update the table and go from there. Views would be amended as needed, and feature/unit/integration tests would be added/changed as necessary.
