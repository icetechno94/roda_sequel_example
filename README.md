# roda_sequel_example

Roda + Sequel example

## Instalation

    bundle install

    rake db:create:dev
    rake db:create:test

    rake db:migrate:dev:up
    rake db:migrate:test:up

    rake seed:dev

## Up application

    RACK_ENV=development rackup

## Routes

### Receive user roles
    
    '/user/roles?uuid=USER_UUID&limit=LIMIT&offset=OFFSET

### Receive role users

    '/role/users?key=KEY&limit=LIMIT&offset=OFFSET

## Up Irb

    rake irb:dev

## Run specs

    rspec