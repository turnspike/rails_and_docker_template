# build base docker image
docker-compose build
# create new webapp, --force overrides Gemfile.lock
docker-compose run webapp rails new . --force --database=postgresql
echo edit config/database.yml to include these lines:
echo   host: db
echo   username: postgres
echo   password:
echo
echo then run:
echo docker-compose run webapp rails db:create
