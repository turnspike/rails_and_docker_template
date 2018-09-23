# build base docker image
docker-compose build
# create new webapp, --force overrides Gemfile.lock
docker-compose run webapp rails new . --force --database=postgres
