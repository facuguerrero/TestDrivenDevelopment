Job Vacancy Application - Helsinki
==================================

[![build status](https://gitlab.com/Facuguerrero/helsinki2/badges/master/build.svg)](https://gitlab.com/Facuguerrero/helsinki2/commits/master)

Relevant Links:
----------------------

* YouTrack: https://helsinki-jv.myjetbrains.com/youtrack
* Heroku: https://helsinki-jobvacancy.herokuapp.com/

----------------------

Once you have clone this repository, follow these steps to start working:

* Run **_bundle install --without staging production_**, to install all application dependencies
* Run **_bundle exec rake_**, to run all tests and ensure everything is properly setup
* Run **PADRINO_ENV=development _bundle exec rake db:migrate_**, to setup the development database
* Run **PADRINO_ENV=development _bundle exec padrino start_ -h 0.0.0.0**, to start the application in development mode. 

Once the application is running you can browse it on http://localhost:3000

To work with Postgres
----------------------

Perform the following commands to create the databases:
````
sudo su
su - postgres
psql
create database jobvacancy_development;
create database jobvacancy_test;
CREATE ROLE jobvacancy WITH LOGIN PASSWORD 'jobvacancy'  CREATEDB ;
GRANT ALL PRIVILEGES ON DATABASE "jobvacancy_development" to jobvacancy;
GRANT ALL PRIVILEGES ON DATABASE "jobvacancy_test" to jobvacancy;
````

Some conventions to work on it:

* Follow existing coding conventions
* Use feature branch
* Add descriptive commits messages in English to every commit
* Write code and comments in English
* Use REST routes


Using Vagrant
-------------

A Vagrant configuration is provided with project. To work with it follow these steps:

* Run _vagrant up_ to start a virtual machine with all the required development tools
* Once the machine is up and running, run _vagrant ssh_ to log into the VM
* Once in the machine go to /vagrant directory and execute the statements described in top of this file

