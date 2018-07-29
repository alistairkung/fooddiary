FROM ruby:2.5.1

ENV APP_PATH /opt/app

RUN mkdir -p $APP_PATH

ADD . $APP_PATH/

WORKDIR $APP_PATH

RUN bundle install

CMD ["rerun", "--background", "--", "rackup", "-p", "4567", "--host", "0.0.0.0"]
