# README

It's a simple shopping cart application where has a CRUD for cart as email and product CRUD.
Also you can extract csv fields with detail for CRUD's, they are saved in S3 Amazon
 Web Services 

# Back End

The app backend is developed using Ruby on Rails. This framework is an online application framework by the server written in Ruby.

#Install

Clone the repository

git clone git@github.com:Glaukg/shopping-cart.git

cd shopping-cart

#Ruby version

ruby -v

The ouput should start with something like ruby 3.0.3p

If not, install the right ruby version using rbenv.

#Rails Version

rails -v

The ouput should start with something like Rails 7.0.1

#Gems 

* pg
* rack-cors
* dotenv-rails
* aws-sdk-s3

#Database creation

See config/database.yml

Database is use postgresql

Initialize the database

* rails db:migrate

#Serve

rails s

#Add heroku remotes

Using Heroku CLI:

* heroku rails db:migrate

#Online Application

* https://shopping-cart-ks.herokuapp.com

#Deployment

* heroku login
* heroku git:clone -a shopping-cart-ks
* cd shopping-cart-ks

