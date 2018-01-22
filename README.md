# README

## About

I used the gem [Wicked](https://github.com/schneems/wicked) to assist in creating a step-by-step flow.
Due to the limitation of creating a User at the end of the flow only, I created a `UserValidations` class that validates each step of the flow. The User model only verifies if the necessary fields. 

## To setup

* `bundle` 
* `rake db:migrate`

## Test

* `rake`