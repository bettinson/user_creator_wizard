# README

## About

I used the gem [Wicked](https://github.com/schneems/wicked) to assist in creating a step-by-step flow.
Due to the limitation of creating a User at the end of the flow only, I created a `UserValidations` class that validates each step of the flow, saving the data in `session`. At the end of the flow, I unmarshal the session data, trim it to only the specified fields, and create a User. The User model only verifies if the necessary fields are filled - the `UserValidations` class validates `params` as they come in. Another design could have been creating a temporary user at each step with a mixed-in `ActiveModel::Validator` class that represents the current step.

## To setup

* `bundle`
* `rake db:migrate`

## Test

* `rake`