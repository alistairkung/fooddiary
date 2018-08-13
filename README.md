# Food Diary App

This is a app currently has the following endpoint:

POST /fetch-meals

```
{
  "data": {
    "meals": [
      {
        "picture_url": "AN_URL_TO_burger.jpg",
      },
      {
        "picture_url": "AN_URL_TO_soup.jpg",
      }
    ]
  }
}
```

View at: http://localhost:4567/

## Requirements

- Ruby 2.5.1 >=
- Docker. You can find more info here: https://docs.docker.com/install/linux/docker-ce/ubuntu/
- AWS S3: Find info here: https://aws.amazon.com/s3/

## Development

Create a .env file in the root directory.

Configure the following variables to use your S3 Bucket:

```
S3_ACCESS_KEY=
S3_SECRET_KEY=
S3_REGION=
S3_BUCKET=
```

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

- Configure environment variables
- Install dependencies by running: `bundle install`
- run:

```
    bundle exec rackup -p <port>
```
