# 1. Getting Started!

Step 0 is getting Ruby, Rails and Git installed. If you were not at the Install Party and haven't done that yet, check out the "Getting Started" page.

First, we're going to fetch the Rails Girls app's starter code from the Internet and place it in a folder named `projects`.

First, let's make the directory:

    mkdir projects

Then, we will change directory (aka `cd`) into the new `projects` directory:

  cd projects

And to get the code from the internet, we ask the `git` program to `clone` it from Code Park:

    git clone https://github.com/codeparkhouston/rails-girls-miniposts.git

Finally, we change directory (again `cd`) into the project itself:

    cd rails-girls-miniposts

Now if you run the `ls` command, you should see a bunch of folders with names like `app`, `config` and many more. The first action we take is to install some libraries. A library, in programming, just means "useful helper program". Once upon a time, finding and installing libraries could be a lot of work, but Rails makes this easy. All we do is use the command:

    bundle install

This may take a while, and you will see a list of all the tools that are being installed. Eventually, you should see the last two lines:

    Your bundle is complete!
    Use `bundle show [gemname]` to see where a bundled gem is installed.

This means all of the libraries installed successfully. Now our app can start building web pages!

To start the server for the first time, run:

    rails server
    [windows] bundle exec rails server

Windows note: When you run the server for the first time, it might ask if you want to let it through the Windows firewall. Please do Unblock it.

Now if you open [http://localhost:3000](http://localhost:3000) in your web browser, you should see the "Welcome aboard" page, which means everything is working correctly!

Notice that when the server is running, the command line prompt, which is either a dollar sign `$` or greater-than sign `>` is gone. This is because while the server is running, it has control of the terminal. To stop the server and be able to run new commands in the terminal, hold `CTRL` and press `C`. You will sometimes hear people say `CTRL-C` as if it were a verb, because this is a very common way to politely ask a terminal program to stop.


# 2. Name your app and make a page!

First we're going to give our app a name and give it a real home page.

In order for our server to know how which page to show for each web address, we use "routes" that connect a web address' path. For example, we might want to connect [http://localhost:3000/users](http://localhost:3000/users) to a page that shows a list of users. For now, we will add a basic homepage, known as the "root path" because it is what appears when you go to the main web address of an app.

Open `config/routes.rb` and you should see

    Railsgirlsminiposts::Application.routes.draw do
      resources :users, :posts

    end

On a blank line anywhere between `do` on the first line, and the `end` on the last line, add:

    root to: 'static#home'

This tells the server that the "root path" should be connected to the "home" action in our "static" controller. What page is our "home" page? Let's refresh the browser and find out.

There are some handy links at the top of the page, but not all of them work yet. Making them work is part of our goal for today!

Now, let's start making this app more of your own creation. Open `app/views/layouts/application.html.erb` in your text editor. Look on line 4 where it says:

    <title>Mini Posts</title>

Between the `title` opening and closing tag, you can change the name of your app as it shows in your browser. Try it and refresh the page in your browser!

Once you've seen the title changing a bit, hit `CTRL-C` in the terminal with the server to stop it for a while.


# 3. Let's make some users!

We're going to make users now. Our users will be simple: A name and an email. Rails has a helpful tool called a "generator" that can make a "model" for us which represents a user and assists in keeping users around in a database. To use this model generator, run:

    rails generate model User name email
    [windows] bundle exec rails generate model User name email

This command should say that it has made a whole bunch of files for you. We'll look at those in a moment, but first we need to run some commands to update the database and restart the server:

    rake db:migrate
    rails server
    [windows] bundle exec rake db:migrate
    [windows] bundle exec rails server

When you load [http://localhost:3000/](http://localhost:3000/) again and click the "List All Users" link the navigation bar at the top, you will see a page saying it is "Listing All Users" but has nothing else. This makes sense: We have not made any users yet. There is also a "Make New User" link. Click it.

You will see a page that just has one form field where you can type user's name, and button to finish and make the user. And remember when we made the User model? We had a user name and an email. Let's add both of those. Open up the file `app/views/users/new.html.erb`

You can see a section that says

    <div class="form-section">
      <%= f.label :name %>
      <%= f.text_field :name %>
    </div>

This makes the single, lonely "Name" label and form field we see on the page. We want to add another named email, which looks very similar, right below it:

    <div class="form-section">
      <%= f.label :email %>
      <%= f.text_field :email %>
    </div>

When you refresh the page, you should see this new Email field! Now we need to have a way to submit the form. Right below the email field in `app/views/users/new.html.erb` let's add:

    <div class="form-section">
      <%= f.submit 'Create User' %>
    </div>

And when we refresh the page we the button now exists. You can now make a user!

But there's one last detail: Users can be made without a name or email, even though we really want them to have both. Adding a check on bits of data is called "validating" it. So in our User model file (I promised you we'd get back to it!) we need to add some code. Open up `app/models/user.rb` and make a two new lines before the `end`. In there, we'll type:

    validates_presence_of :name
    validates_presence_of :email

This will do exactly what it says: validate that a user must have both a name and email. Try making a user with no email or name now, and you should see the form get mad at you.

Now you can play around, make users, and see them on the "List All Users" page.


# 4. Create the Posts Model!

We want users to be able to have mini-posts. As with users, we first want a model which represents a Post. Rails can once again help us out with the same generator as before:

    rails generate model Post body:text user:references
    [windows] bundle exec rails generate model Post body:text user:references

Note that unlike last time, we have a colon followed by another word within the command. This tells Rails we want something special with that attribute of a post. For instance, we want the body of the post to be a special kind of long text, so we say `:text`, and we want a single Post to be owned by a particular User so we say that the post `:references` a User.

Just like when we made the User model we need to run two commands after generating the model to update the database and restart the server:

    rake db:migrate
    rails server
    [windows] bundle exec rails server
    [windows] bundle exec rake db:migrate

If you open update the model file `app/models/post.rb` you will see the details of the Post model. Interestingly, you see the line

    belongs_to :user

Which does just what it says: a Post belongs to a User. Similar to requiring name and email our User model, let's add these two lines below that one to require post's body not be blank:

    validates_presence_of :body

The whole file of `app/models/post.rb` will be quite short:

    class Post < ActiveRecord::Base
      belongs_to :user
      validates_presence_of :body
    end

Now we can open the User model again at `app/models/user.rb` and just before the validations, say that a User can have many Posts by adding:

    has_many :posts

To be able to see posts on a User's page, let's add the following to the bottom of the file `app/views/users/show.html.erb` in our text editor:

    <% @user.posts.each do |post| %>
      <div class="post">
        <p><%= post.body %></p>
      </div>
    <% end -%>

What this does is say "take each of a user's posts, and show the body of the post". When we view a user's page on the server, even if we did everything right, it nothing has changed because we haven't made any posts yet.


# 5. Finally: New Posts!

First, we need to be able to get to the page. For that, we'll make a new link on the navigation bar that appears at the top of every page. This is in our global layout, where we set our app's title, located at `app/views/layouts/application.html.erb`. Open that and look at the

    <div class="navigation-bar">

that starts on Line 11. This section controls the buttons at the top of all the pages. We want to add another button that looks like the other two, so on Line 19 we'll add the following:

    <li>
      <%= link_to "Make New Post", new_post_path %>
    </li>

and the whole section will look like this:

    <div class="navigation-bar">
      <ul>
        <li>
          <%= link_to "List All Users", users_path %>
        </li>
        <li>
          <%= link_to "Make New User", new_user_path %>
        </li>
        <li>
          <%= link_to "Make New Post", new_post_path %>
        </li>
      </ul>
    </div>

Now when you reload any page, there is a "Make New Post" link at the top. Click that and let's check it out!

Just like when we made the New User page, the file is called `new.html.erb` but this time it is located at `app/views/posts/new.html.erb`. Open it in your text editor.

And just like with our user form, this form is not complete yet. We can see there is a section for which User the form should belong to. Now we need a way to add the body of the Post. This is different from the previous forms we added. It needs to be a bit larger, so we use `text_area` instead of `text_field`:

    <div class="form-section">
      <%= f.label :body %>
      <%= f.text_area :body %>
    </div>

And just like with the new User form, we need a button to submit it:

    <div class="form-section">
      <%= f.submit 'Post It!' %>
    </div>

Now when you reload the "Make A Post" page, you will be able to make posts. Even better, the posts will immediately be added to the user you select!

