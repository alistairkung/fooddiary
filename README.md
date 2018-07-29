# Food Diary App

This is a app currently has a root endpoint that returns a 200 response:

View at: http://localhost:4567/

## Requirements

- Ruby 2.5.1 >=
- Docker. You can find more info here: https://docs.docker.com/install/linux/docker-ce/ubuntu/

## Development

In order to boot the up the app you need to run the following command that will
launch the web server at http://localhost:4567:

```
docker-compose up
```

## Test

```
docker-compose run --rm app bundle exec rspec
```

## Production

- Install dependencies by running: `bundle install`
- run:

```
    bundle exec rackup -p <port>
```
