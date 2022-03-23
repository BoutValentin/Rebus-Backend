# Rebus Backend Ruby on Rails

This repo is for the backend of the rebus game for the project.

### Tools

- We use the [ruby on rails](https://rubyonrails.org/) framework in the 7.0 version. We create an API with it.
- We use [postgresql](https://www.postgresql.org/) as the database.

### Ruby version

The ruby version of this projects is 3.0.2.
You can change your ruby version with [rvm](https://rvm.io/).

### Install project

First of all, you need to install the gem usefull for the project.

```sh
$ ./bin/bundle install
```

Next you need to create the database (we are using postgresql).

```sh
$ ./bin/rails db:drop
$ ./bin/rails db:create
```

We need to fill the databse with the migration to create the database.

```sh
$ ./bin/rails db:migrate
```

Finaly you can add some example data to the databse using seed

```sh
$ ./bin/rails db:seed
```

### Launch the server

When you have go through the install project you can now launch the server.

```sh
$ ./bin/rails s
```

This command create a server ready to handle connection. The server is available at [http://localhost:3000/](http://localhost:3000).

### Access documentation

To know more about the API, you can access to [http://localhost:3000/api-docs](http://localhost:3000/api-docs). This page expose the documentation for the API has a swagger documentation.

### Run test

You can run the API test by running

```sh
$ SWAGGER_DRY_RUN=0 ./bin/rake rswag:specs:swaggerize
```

You can run the string extension test by runnning

```sh
$ ./bin/rails test test/lib/string_extensions_test.rb
```
