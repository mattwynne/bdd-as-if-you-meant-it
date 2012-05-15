BDD as if you meant it
======================

Source code for the tutorial used in Matt's __BDD as if you meant it__ session at [Turku Agile Day](http://turkuagileday.fi/).

## Getting started

This codebase is just a stub to get you ready to start the tutorial. Here are the steps you need to take:

Before you do anything, make sure you have installed Ruby. Follow the instructions for your chosen platform at http://www.ruby-lang.org/en/downloads (1.9.3 is recommended).

Now install [bundler](http://gembundler.com/):

    gem install bundler

Clone this repository:

    git clone git://github.com/mattwynne/bdd-as-if-you-meant-it.git

Change directory:

    cd bdd-as-if-you-meant-it

Ask bundler to install the neccesary Ruby gems:

    bundle

We'll use [Guard](https://github.com/guard/guard/) to run our tests continuously. Fire it up like this:

    bundle exec guard

That's it!
