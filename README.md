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

#### Initial Planning Doc:  
[Planning Doc](https://github.com/Rhoxio/influence-offers/wiki/Setup-Planning-and-Tech-Choices)  
Many of the concerns didn't come to pass, but I just checked things off as I went and didn't edit it much to see just how much I was able to cover initially. It definitely helped with the database and initial setups, though. The pull requests are a far better look into what got done. 

## Setup:  
Install [Node](https://nodejs.org/en/download)  
   - You can check which node version you are running by running: `node -v` 
   - More recent versions work just fine. My version is: `v18.16.0`
   - If you had to install Node, you'll need to reload your `.bash_profile` (or whatever you're using to load `PATH` variables) or reopen the shell.

Clone the repo down using: `git clone git@github.com:Rhoxio/influence-offers.git`

run `cd influence_offers` to navigate into the project root.

Ensure you have Ruby version `3.1.2` installed and active by running `ruby -v`.
   - `rvm` or `rbenv` commands might be required depending on your local environment
   - [rvm docs](https://rvm.io/rvm/cli)
   - [rbenv docs](https://github.com/rbenv/rbenv)
   - A `.ruby-version` file exists in the project, so it has the correct reference for version management tools

run `bundle install` to install gems/dependencies
   - Double-check that Foreman is installed by running `gem list -i "^foreman$"` if it returns `true`, you are good to go.
   - If it retuns `false`, run `gem install foreman`. It's included in the `Gemfile`, but this is an extra precaution to check since Shakapacker uses it to watch for changes in development mode. 
 
run `yarn` to install JS dependencies
   - Make sure that port `3050` is not running anything. Shakapacker needs it for the dev server.

add `EXECJS_RUNTIME=Node` to your environment (for Shakapacker/React)
   - You can use `export EXECJS_RUNTIME=Node` temporarily unless you want to edit your shell/bash/zsh profile. Just be aware that if you open a new window, this will be un-set.
   - I noticed that my environment didn't seem to care if I had this set or not, but yours might.

run `rails db:setup` to prepare the database and run migrations
   - This should create the database, migrate, and seed the data. 

run `./bin/dev` to start the server with Shakapacker (This runs a `rails s` command - you'll see the output for both Shakapacker and Rails)  

navigate to `http://localhost:3000` in your browser to begin using the app

## Running Tests:
run `rspec` in the project root

## Before Reviewing...
 - When you get to the Discover Offers page, you can open the browser console and click on any of the offers to get a `console.log()` of the weight data for each offer. It's just in there for transparency. I was using it fer debugging so I kept it in so you all can see 'under the hood' more easily.
 - You can view the ActiveAdmin panels by visiting `/admin`. I didn't put a password auth on it in this case, but normally I would hook it up to Devise.

## My Thoughts:
### Retrospect:
Overall, the project was fun and interesting to build! I am used to dealing with larger scales of complexity and having to worry about future-proofing, so this was a nice respite from that. This also distanced from making vain attempts at predicting the future to design flexibility into the right parts of a system. If this app were to grow larger and actually integrate with external API services, I would definitely be able to make changes quickly as the build followed KISS principles and produced solid, working functionality without exploding scope on niceties and including too much functionality for the relative simplicity of the data modeling and UI. Things are by no means perfect, but I made an attempt to build the app with the 'right tool for the job' attitude while constantly questioning my previous assumptions. 

Of course I can add things like Sieqkiq and Redis for background processing, Opensearch for weighted queries, more nuanced abstrations to better evoke the potential of the data model and provide more explicit interfacing... the list goes on about the things I **COULD** do. This project was about setting a limit and doing the best I could within that scope, and I feel I was successful. I learned a lot about how I feel software should be written, and at the end of the day, how I can help others write better software and provide insights from direct experience versus the top three results on Google. One of the wonderful things about software is that every time you write something you are reinforcing something that you learned previously and teasing the nuance from it. You can write the same code twice in different context - but you express the same heirarchies of thought in different ways all the time!
***
### Feedback:
Overall, I liked the project and REALLY appreciated the loose deadline. Even though what you proposed seemed like a simple CRUD app, there's hidden complexity when it comes to implementing the age and gender offer suggestion feature. Do they just use `.sample`? Do they build a system to suggest? Do they build a UI to cycle matching records? There are definite possibilities, and having enough freedom to hang yourself with and seeing how devs reign in scope seems like a good plan!

The proposal doc gave me enough information to plan out a very basic Rails app, but anything past that was almost too open to interpretation. I felt like it was almost TOO non-specific and wasn't clear on some of the terminology. I read it closely a few times before writing/planning anything, but cursory reads afterwards sometimes freaked me out and I felt like I missed something. It was just an impression I had - I don't know how actionable it is. I can think of a million reasons why the doc provided was sparse, but I'll never know unless I'm hired and you tell me! 🙂

I have a [retired hiring proposal doc](https://gist.github.com/Rhoxio/d78343d4caf0a4ca3eb60e40b6047d78) I created and used to hire a Front-End developer and can share publicly (and legally, as it became public over a year ago) - I think it is a fair example of something more specific. I got a really great and talented hire from it out of ~30 people I gave it to, so I like to think it did a good job of vetting people. Just food for thought, of course! 
***
## Challenges

### The Great React and Shakapacker Disaster of Dec, 2023
[In this pull request](https://github.com/Rhoxio/influence-offers/pull/3) I outline the largest challenge of the project outside of scoping: dependency management and file linkage debugging in the context of libraries that 'worked' on initialization and initial setup, but broke inexplicably with no changes to the code in a project that already has hours of code, work, and planning put into it. 

### Scope
Stopping myself from going overboard on the scope and abstraction aspects of this project was the next big challenge. I've been so used to building larger things, and having to cut my expectations back and focus on creating a solid base wasn't a skill I've had to exercise as much as 'building on top of 50 other models' kind of work. I was constantly thinking things like, "Man, I want to set this Sidekiq task up to handle this stuff async and save the generated suggestions instead to decrease response speed and give us more metrics, but it's just straight up out of scope!" or "I want to use Opensearch to make the Offer weighting scalable with settings and use their awesome query interface, but it's out of scope!". I couldn't introduce other technology dependencies because it would make setup on your end too cumbersome even though I knew of a great technology to use! So, I had to write code to do things that were "good enough". That's a part of being a software dev sometimes, and it did give me some valuable persective on how I tend to think about software development in modernity where "just use this service" mentatlities are both a blessing and a curse. 

### Clarity
If you haven't noticed, I do like to write about the software I produce. I made an extra effort to write clear commit messages, write comments in pull requests, and generally just be communicative. I was doubly dilligent about being explicit this time. 

### Putting it All Together
My planning doc helped some, but I quickly realized that it wasn't fully comprehensive and I would have to start making decisions I had no presupposition about. I'm used to this to an extent, but it's never an easy thing to do on any software project. 

***
## Reasonable Changes to Project Proposal in Implementation:  

### Instead of a unique `user_name` field, the project uses `email`.  
This is based off of the assumption that collecting emails as contact information and added functionality like resetting passwords would be baseline in most apps like this.
  - If we strictly want `user_name` and NO `email` column, I would `remove_column: :players, :email` and change the Devise settings to use `user_name` for sessions instead. If I needed to, I would add validations on the `Player` model to `validates :user_name, presence: true` and `validates :user_name, unique: true`. Views would be amended as needed, and feature/unit/integration tests would be added/changed as necessary.
  - If the `user_name` column needs to be ADDED to the `Player` modeling/schema, the same `:unique` and `:presence` validators would be used. I would `add_column: :players, :user_name, :string` to update the table and go from there. Views would be amended as needed, and feature/unit/integration tests would be added/changed as necessary.

### Each Offer is Targeted to a specific age and gender **group**.  
I wasn't sure if this meant that you could add multiple genders to an Offer, but that's how it's built. My developer brain went 'group' and said, "Oh, I misinterpreted the document hours before I promised to submit it. I need to crank out this change!", so I did. I looked back at the doc again and realized that the open interpretation of 'group' probably meant 'gender groups as a whole' and not 'association linkage'. Either way, the functionality works fine and now there's the ability to add multiple genders to an Offer's targeting!

I was VERY happy with how easy it was for me to change the code to support an array versus a string value. While the project isn't big, it only took me about an hour and a half of dev work including modeling, tests (factories and inline creation in tests), seeds, controller changes, suggestion system changes, and to amend the views. My tests did EXACTLY what I needed them to do, and I was ecstatic about how easy they made it to change something that prevalent and important throughout the app's server code. This is one of the big reasons why I write tests - it's like investing in your future self. 

## Technology Decisions
#### Gems
[Shakapacker](https://github.com/shakacode/shakapacker)  
[react_on_rails](https://www.shakacode.com/react-on-rails/docs/)  
I definitely wanted to use React, not only because it was listed as a 'Bonus', but because I have worked with it before and wanted to see where I was at with it since I have been leaning toward back-end and architecture more the past few years. React is arguably the most popular library for front end development, and I have liked working with it in the past. The features in the UI didn't lend themselves to hacking away with vanilla JS - I needed a state management option. React just seemed like the natural choice when combining concerns from the requirements doc and my experience with building similar feature sets. I ended up going with `Shakapacker` and `react_on_rails` due to a previous setup not working currently with `react-rails` and `Shakapacker`. It was a major debugging session, and the pull request with details can be found [here](https://github.com/Rhoxio/influence-offers/pull/3).

[activeadmin](https://activeadmin.info/index.html)  
I wanted to have an admin tool so I could CRUD easily without having to run console commands or write and edit scripts. Activeadmin is a quick way to get this done and provides a nice UI for viewing data. It comes with the added bonus of allowing the Influence Mobile devs to tinker with things as well.

[devise](https://github.com/heartcombo/devise)
I mean... why not use Devise for sessions? I didn't want to write a bunch of boilerplate controllers/bcrypt password hashing/sessions/helper methods stuff manually. Seems perfectly reasonable. Devise is something that I have used for at least 7 years when working with Rails apps. It's widely used and is very customaizable with strong defaults, so it was the natural choice for an auth solution.

[pry](https://github.com/pry/pry)  
I like using pry to help me debug. It's also nice to help you write tests without having to stare at reference files and try to follow the logic backward and forwards. "Is this variable set correctly? -checks it- Oh yeah, thats not right..." versus "Log this variable... rspec... ok its wrong. Try again." It just makes the development flow far better and saves me large amounts of time.

[faker](https://github.com/faker-ruby/faker)  
[factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)  
[rspec-rails](https://github.com/rspec/rspec-rails)  
[shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)  
[database_cleaner-active_record](https://github.com/DatabaseCleaner/database_cleaner)  
Testing gems! 
  - `faker` is nice because I don't have to write in boilerplate test data and think of unique names.
  - `FactoryBot` is great because it provides me with a simple way to create and manage fixtures/test data.
  - I prefer `RSpec` just because I enjoy the terse syntax more than something like `Minitest`. It's just a preference, but I've almost always chosen to use `RSpec` for testing Rails apps.
  - `shoulda-matchers` is SUPER nice for writing unit tests - validations, db columns, and [assosciations can be tested using one-liners](https://thoughtbot.com/upcase/test-driven-rails-resources/shoulda_matchers.pdf). Less code for me to write and maintain - always a HUGE bonus!
  - `database_cleaner` just helps me keep the database clean when I go to run tests. It's helped me keep Redis and Opensearch in-line in the past and is part of my standard dev testing setup.  

[pg](https://github.com/ged/ruby-pg)  
Using Rails with Postgres? You need it!

[foreman](https://rubygems.org/gems/foreman)  
Required for Shakapacker to work. 


***

## Code Design
I did my best to keep scope as limited as possible while providing features and tooling that is robust but not rigid. I opted to use Service objects (for interfaces and pure data aggregation) in this project because of the relatively low amount of overall complexity. I paid special attention to keeping the code SOLID so it can be easy to work with as well as provide a solid baseline for future code changes and the introduction of new paradigms. If the need arose, I would organize the interfaces into their own directory and keep processing and data services away from them just for the sake of clarity.

### **Features:**  
I ensured that the spirit of the proposal was kept alive - **Offers with targeting on `age` and `gender`**. In this vein, I also decided to add a `suggestions` weight system that takes into account `tags` and the total times an offer had been claimed by other users as well. The end result ended up working really well, and the weights system was fun to put together! Auth was simple enough with Devise views, and the React UI pieces were more an exercise in keeping things clear and ultimately usable. I provided a `tags` filter with multi-select to help find things Users might like. I opted to NOT include text search as the data in the system is just not terribly actionable against text, and the semantics of the associated and weighted data is far more important. 

### **Data:**  
The data itself was relatively simple - only 3 join tables and 4 base models overall - but I made sure to validate EVERYTHING that goes into the database. This was doubly true due to the nature of the Suggestions system and the dependencies on weighing ratios to produce actual suggestions and not garbled edge-cased nonsense. I needed explicit ranges for `Player.age` and the `Offer`'s `target_age`, `max_age`, and `min_age` columns to be kept and adhered to. The `gender` attributes did need some sort of limiting factor to them just to keep the complexity down. I included options for, `["male", "female", "nonbinary", "declined"]`. The ability to 'decline to answer' and the introduction of 'nonbinary' was scope enough to produce actionable resuts (and a reasonable amount of mindfulness) without introducing vast amounts of complexity by allowing purely custom genders or trying to include more. I included `dependent: :detroy` on the `has_many` models for associations to keep the complexity of handling edge-cases to a minimum. 

### **Controllers:**
There are both standard HTML-rendering controllers and JSON-API controllers in the app. The API controllers are namespaced under `/api/v1`. The standard HTML-view rendering controllers are very standard. They use Devise (Warden) to authenticate actions and leverage the `OffersFormatter` service to turn the responses into React implementation-specialized responses. `OffersFormatter` works for both the HTML and API controllers - they use dependency injection that takes the queried `offers`. 

The API controllers inherit from a custom class called `ApplicationApiController` that handles default error responses and works with a controller concern called `ApiErrorHandling` to provide consistent error response functionality. Instead of having to case in the controllers, these provide a strong default 'safety blanket' to help limit the exposure of implementation details and provide more actionable error information for user and dev consumption. I would normally pair this with logging architecture, but that would require extra scope creep that didn't feel appropriate to build into this project. The POST/DELETE requests in the API controllers are also gated by  `protect_from_forgery`, so CSRF security is in-place.

### **Views/Styles:**  
I decided to opt for a React and Rails combinatory view rendering strategy. This is mainly due to the scope of the app and how using Devise views is just so much easier and less convoluted than using [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) with a pure API. I wanted to use React, and I knew that using embedded components would serve me well. It kept things simple, secure, and functional without (much) configuration overhead. It just made the most sense for what the app is. If the app was larger (or going to become larger), moving away from the combinatory model is reasonable and the way that most projects go if they use React. I established a good baseline in the API controllers because of this, as I don't want to have to build tooling from scratch later if the need arose and the current code would already be using the paradigms established and could simply build off of them (if it was deemed appropriate, at least).  

I opted to use pure SCSS due to the scope of the app being small. I wanted granular control over how the media queries worked to reduce the amount of edge-casing and HTML class-wrangling needed when I switched from doing the mobile styles over to desktop styles. Libraries are great, but I didn't need to have a fully nuclear styling setup where I would spend more time in their documentation than just writing the styles myself. If this was a larger app, I probably would have chosen [Tailwind](https://tailwindcss.com/). Custom styles allowed me to reduce overiding and the number of classes I had to manage overall in the views, which is another small bonus as there just isn't a ton of style code overall. It's namespaced parent-to-child with some variables and shared classes to speed development and reduce redundancy.

As for the actual view code, React ended up being a good choice. I made sure to define a Context so the form and list displays would work well without prop drilling. It was all written using functional components, and the most challenging part was setting up the heirarchies so if I needed to tinker with Offer state, it wasn't more than one component away/was already in Context. The React code is fairly simple, but it does a good job and includes AJAX and error handling functionality. 

### **Spec/Tests:**  
I focused heavily on writing tests that provided stability and covered edge-casing. I don't follow strict TDD, but I will TDD models and their validations before writing them to make sure that I don't miss cases because of context switching. I always audit the code I am working on and review my tests before I move on because I have the whole context in my head and can better judge where the holes might be after the functionality is prototyped. (If I had a full comprehensive spec, I would TDD much more) I have unit, integration, and some view/feature tests written. I decided against setting up `selenium-webdriver` and fully feature testing this app because past experience has told me not to make assumptions about other people's development envronment - especialy when it comes to Selenium. I have war stories about getting it to run on other machines, and I wanted you all to be able to just get the thing up and running quickly without much setup overhead. Views are tested as far as `rack-test` settings would get me in `Capybara`. 

***
## Some Strong Opinions, Loosely Held (on things I didn't have scope to design and build this time)

### **Validations, Callbacks, and Interfaces:**
In general, I keep my model callbacks limited strictly to things that should happen AROUND a transaction that DEALS ONLY WITH THE MODEL DATA IT IS PRESENT IN - not as way to validate (we have Validator classes for that) or deal with any associated model. I feel that those are best left to a service object or an interface of some sort. One reason for this is overall performance, as callbacks get run on every transaction. You can add guard-clausing to make it not run the whole callback, but it still gets called and runs the risk of producing side-effects completely by accident as you develop on top of the class. Another reason is that if you are running queries to other tables every time you transact on top of the standard ActiveRecord queries, you are creating an environment that introduces performance creep and dev overhead/tech debt due to the order in which they are called. This feels like a direct affront to keeping concerns separated and classes modular. I don't hate callbacks, but you need to be very metered about how you use them and heavily consider scope and the use-cases before doing so. 

Instead, I opt to use a service like `OfferClaimer` as an association-assignment interface where all of the logic and necessary transactions can live and work in their own encapsulated environment. Dependency injection is important if you do this, because there's no good way to tell what the best query will be every time you need to associate a model and run some logic against the transaction. Using something like the shovel operator `<<` is super convenient and nice, but can also be seen as Rails giving you just enough rope to hang yourself with if you aren't careful about the implications of shoving something into an association. This is why I have `OfferClaimer` present in the codebase - it was in preparation for transaction manipulation in case I needed it later. 

**TL;DR, Encapsulation and single-responsibilty is important, so using interfaces to handle combinatory data actions is cleaner and easier to maintain than callbacks. We should use validator classes for validation and leave callbacks for same-model scoped tasks within reason.**

### **Composition vs Inheritance:**  
In general, I tend to favor composition over inheritance in Rails apps. The complexity of this app didn't really have me writing shared logic on associated data or anything quite that abstract, but I wanted to mention it since I didn't have the opportunity to show how I like to design shared functionality. 

While inheritance is powerful in many situations, it also has a proclivity to make code written later more coupled to previous implementations and can introduce methods that are there to 'cover holes in the missing method implementation' (`NotImplemented`) than dealing it at the root - which in Rails is usually the data/schema itself due to how ActiveRecord abstracts everything. Heierarchies are data/implementation coupling in and of themselves, and I prefer my interfaces to be more flexible and extensible (horizontal, really) without having to worry about adapting the superclasses or child classes appropriately. Keeping things closer to the source just simplifies things, really. 

Composition requires a more abstract data dependency, but in well-tested Rails apps I have found this to be far more appealing. It also provides you with more options to abstract and can be readily 'plugged in' without relying on a 'tower' of class dependencies - it's only as tall as the dependencies are nested in the code in the concern itself. Setting up a data expectation modularly and ensuring that good tests are written has worked out better for me from a maintenance and extensibility perspective in my previous work. 🤷‍♂️ I think that maintaining abstractions that can apply to many different cases is simply easier and less cumbersome with composition. 

**TL;DR, I would have written concerns for shared functionality with ample complexity/abstraction cases over using inheritance because keeping data and functionality closer to the source just makes more sense to me in a Rails context.**

## Final Thoughts

### Thank you for taking the time to review my code and look over what I have prepared! I'm looking forward to hearing back from you and, hopefully, joining the team in the near future!
