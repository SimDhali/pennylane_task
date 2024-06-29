# README

### Approach

For this task I have used PostgreSQL and Ruby on Rails. I have tried to keep the functionality as simple as possible. The way in which I have approached this task is to return the most relevant recipes (based on a users input of available ingredients) based on the `matching ratio`. This ratio has been designed to calculate the the best "submitted ingredients" to "recipe ingrdients". The results are limited to the top 20 results with the most relevant appearing at the tope of the list.

A user can view each indivudal recipe and in the show page, a ✅ will appear next to the ingredient recipe that the user has submitted. The user can also mark a recipe as 'tried'

### Tech Stack

- Ruby on Rails
- PostgreSQL
- HTML/CSS
- JavaScript

### User Stories 

1. As a user I can input ingredients and have the most relevant recipes returned (top 20)
2. As a user I can mark a recipe as 'Tried'

# Setup

### Prerequisites

- Ruby (version 2.7.1 or higher)
- Rails (version 6.0 or higher)
- PostgreSQL

### Set up the database:

1. Run `rails db:create`
2. Run `rails db:migrate`
3. Run `rails db:seed`

### View the app

* Hosted on fly.io 
* Go to https://recipe-finder-holy-moon-2691.fly.dev/ 
