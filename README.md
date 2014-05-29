# SMC-Connect Admin

[![Build Status](https://travis-ci.org/smcgov/SMC-Connect-Admin.svg?branch=master)](https://travis-ci.org/smcgov/SMC-Connect-Admin)

This is an admin interface for the data that appears on the [SMC-Connect](http://www.smc-connect.org) website. It allows organization members to sign up with their organization email address, and allows them to update the locations that belong to their organization.

If someone signs up with a County email address that ends in @smcgov.org or @co.sanmateo.ca.us, they will need to ask someone who has "Master Admin" access, like Edwin Chan, to add them as an admin for the locations they need to update.

## Stack Overview

* Ruby version 2.1.1
* Rails version 3.2.17
* MongoDB with the Mongoid ORM
* Testing Frameworks: RSpec, Factory Girl, Capybara

## Installation
Please note that the instructions below have only been tested on OS X. If you are running another operating system and run into any issues, feel free to update this README, or open an issue if you are unable to resolve installation issues.

###Prerequisites

#### Git, Ruby 2.1+ (+ Homebrew on OS X)
**OS X**: [Set up a dev environment on OS X with Homebrew, Git, RVM, Ruby, and Rails](http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/)

**Windows**: Try [RailsInstaller](http://railsinstaller.org), along with some of these [tutorials](https://www.google.com/search?q=install+rails+on+windows) if you get stuck.


#### MongoDB
**OS X**

On OS X, the easiest way to install MongoDB (or almost any development tool) is with Homebrew:

    brew update
    brew install mongodb

Follow the Homebrew instructions for configuring MongoDB and starting it automatically every time you restart your computer. Otherwise, you can launch MongoDB manually in a separate Terminal tab or window with this command:

    mongod

[MongoDB installation instructions using MacPorts](https://github.com/codeforamerica/ohana-api-admin/wiki/Installing-MongoDB-with-MacPorts-on-OS-X) are available on the Wiki.

**Other**

See the Downloads page on mongodb.org for steps to install on other systems: [http://www.mongodb.org/downloads](http://www.mongodb.org/downloads)

### Clone the app on your local machine.

From the Terminal, navigate to the directory into which you'd like to create a copy of the SMC-Connect Admin source code. Next download this repository into your working directory with:

    git clone https://github.com/smcgov/SMC-Connect-Admin.git smc-connect-admin
    cd smc-connect-admin

### Install the dependencies and run the setup scripts:

    script/bootstrap


### Set up the environment variables
Inside the `config` folder, you will find `application.example.yml`.
Rename it to `application.yml` and double check that it is in your
`.gitignore` file (it should be by default).

By default, the app is configured to point to the
[demo API](http://ohana-api-demo.herokuapp.com/api).
To point to your own instance of Ohana API, change the value of
`OHANA_API_ENDPOINT` in your `application.yml`.

If you made changes to `config/application.yml` in either the Admin
app or the API app, or if you're pointing the Admin app to an API app
that already has `ADMIN_APP_TOKEN` configured, make sure that the value of
`ADMIN_APP_TOKEN` in the API matches `OHANA_API_TOKEN` in the Admin app.

### Run the admin app
Start the app locally:

    rails s

And visit it in a web browser at:

    localhost:3000

### Sign in
The bootstrap script you ran earlier created three users for you that you can sign in with. You can see the username and password for each user in [db/seeds.rb](https://github.com/smcgov/smc-connect-admin/blob/master/db/seeds.rb). When you sign in with the first two, you'll have access to locations whose email or website domains match the domain name of the user's email address. The locations come from the [sample data](https://github.com/smcgov/ohana-api-smc/blob/master/data/sample_data.json) provided by the Ohana API.

The third user is there to let you try the interface as a master admin, but you can set any of the three users as an admin by setting the "role" field to "admin". To do that, you need direct access to your Mongo database. The easiest way to view and update Mongo data is with a GUI like [one of these](http://docs.mongodb.org/ecosystem/tools/administration-interfaces/).

### Test the app
Run tests locally with this simple command:

    rspec

For faster tests (and many other rails commands, like rake):

    gem install zeus
    zeus start #in a separate Terminal window or tab
    zeus rspec spec

To see the actual tests, browse through the [spec](https://github.com/smcgov/smc-connect-admin/tree/master/spec) directory.

The tests will take around 3 to 5 minutes to run. Note that a browser window will open during the integration tests as some of them use the Selenium web driver.

## Contributing

In the spirit of open source software, **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by suggesting labels for our issues
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up
  inconsistent whitespace)
* by refactoring code
* by closing [issues](https://github.com/smcgov/smc-connect-admin/issues)
* by reviewing patches

## Submitting an Issue
We use the [GitHub issue tracker](https://github.com/smcgov/smc-connect-admin/issues) to track bugs and features. Before submitting a bug report or feature request, check to make sure it hasn't already been submitted. When submitting a bug report, please include a [Gist](https://gist.github.com/) that includes a stack trace and any details that may be necessary to reproduce the bug, including your gem version, Ruby version, and operating system. Ideally, a bug report should include a pull request with failing specs.

## Submitting a Pull Request
1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Add specs for your unimplemented feature or bug fix.
4. Run `rspec`. If your specs pass, return to step 3. In the spirit of Test-Driven Development, you want to write a failing test first, then implement the feature or bug fix to make the test pass.
5. Implement your feature or bug fix.
6. Run `rspec`. If your specs fail, return to step 5.
7. Add, commit, and push your changes.
8. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/

## Supported Ruby Version
This library aims to support and is tested against Ruby version 2.1.1.

If something doesn't work on this version, it should be considered a bug.

This library may inadvertently work (or seem to work) on other Ruby implementations, however support will only be provided for the version above.

If you would like this library to support another Ruby version, you may volunteer to be a maintainer. Being a maintainer entails making sure all tests run and pass on that implementation. When something breaks on your implementation, you will be personally responsible for providing patches in a timely fashion. If critical issues for a particular implementation exist at the time of a major release, support for that Ruby version may be dropped.

## Copyright
Copyright (c) 2013 Code for America. See [LICENSE](https://github.com/codeforamerica/ohana-api-admin/blob/master/LICENSE.md) for details.