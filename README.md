# Heirloom API

The API server for the Heirloom application

## Requirements

* Ruby 3.0.0
* Postgres v12

## Setup

```
git clone git@github.com:mattsells/heirloom-api.git && cd heirloom-api

bundle install

rails db:create db:migrate
```

## Start Server

```
rails server
```
