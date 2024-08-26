# Hikaru Blog

## Getting started

To get started with the app, first clone the repo and `cd` into the directory:

```
$ git clone https://github.com/Onizukachi/hikaru_blog.git
$ cd hikaru_blog
```

Then install the needed gems (while skipping any gems needed only in production):

```
$ bundle install --without production
```

Install JavaScript dependencies:

```
$ yarn install
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rspec
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ bin/dev
```
