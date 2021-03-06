# Windows Install Guide

Install Ruby and Rails via RailsFTW:

    http://railsftw.bryanbibat.net/

Select the big red button that says "Download Latest", and when the download is finished, run the `rails-ftw-[some_numbers].exe` file.

The default install options are good, you should not need to change anything. The only thing to watch out for is that the "Install Location" part does not contain any spaces. Ninety-nine percent of the time, it should not have any by default.

Next, we need the 'msysgit' package from a Google Code repository:

    http://code.google.com/p/msysgit/downloads/list?q=full+installer+official+git

Download the most recent version (first in the list). As of February 2014, it will be named `Git-1.9.0-preview[some_numbers].exe`. When it is done downloading, run the file and install with the default options.

When it is done installing, open your start menu and type "bash" in the text box. An option called "Git Bash" should come up. Run that program.

This is your terminal. You will be using this to enter all sorts of commands tomorrow. To make sure everything worked properly, type:

    ruby -v

And hit enter. The next line should show something that starts with "ruby 2.0", possibly with more numbers afterward, a date, and the word "mingw32". Those are all completely fine.

Next run the command, being careful to use the exact spaces and hyphens:

    gem install bundler --no-ri --no-rdoc

And it should say "Successfully installed bundler-1.5.3" and another line "1 gem installed". If that has worked out, you're all set!
