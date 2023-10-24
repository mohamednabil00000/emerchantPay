# README

## Description
It is a simple payment system. consist of two roles(admin and merchant) and three views and one API. Each role has some views and APIs.
 - admin has all transactions view and merchants view with edit & destroy actions.
 - merchant has transacitions view for his transactions only and also has POST API for create transaction.

There is a postman scenario in the app that contains all kind of transactions and also the login for merchant. All you need is to login by merchant to take the auth token and then put it in the rest of apis to create transactions.
## Features
* Rails 7
* Ruby 3.2.1
* Dockerfile and Docker Compose configuration
* PostgreSQL database
* Rubocop for linting
* Rspec & Factorybot
* Integration tests using Capybara
* Slim view engine
* GitHub Actions for
  * tests
  * Rubocop for linting

## Screenshots
![Alt text](/screenshots/login_screen.png?raw=true "Login screen")
![Alt text](/screenshots/merchants_screen.png?raw=true "Merchants table screen")
![Alt text](/screenshots/transactions_admin_screen.png?raw=true "Transactions admin table screen")
![Alt text](/screenshots/transactions_merchant_screen.png?raw=true "Transactions merchant table screen")
## Requirements

Please ensure you have docker & docker-compose

https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-install-Docker-and-docker-compose-on-Ubuntu

https://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/How_to_Install_Docker_Compose.html

Check your docker compose version with:
```
% docker compose version
Docker Compose version v1.27.4
```

## Initial setup
```
$ cp .env.example .env
$ cd docker
$ docker-compose --env-file ../.env build
```

## Running the Rails app
```
$ docker-compose --env-file ../.env up
```

## Tasks
```
# Import users

$ rake users:import\['csv_file_path'\]

for example

$  rake users:import\['/Users/mnabil/emerchantpay/spec/tasks/csv_files/users_csv.csv'\]

you can find csv example file in spec/tasks/csv_files/users_csv.csv

# Delete transaction older than one hour

$ rake transactions:delete
```

## Running the Rails console
When the app is already running with `docker-compose` up, attach to the container:
```
$ docker-compose exec app bin/rails c
```
When no container running yet, start up a new one:
```
$ docker-compose run --rm app bin/rails c
```
## Postman script
```
There is a postman script that contains the both scenarios of the transactions.
you can find it in postman folder.
```

## Seeds
```
Already will run within the docker and the credentials are:

email: admin@gmail.com   password: 12345678   role: admin
email: merchant@gmail.com   password: 12345678   role: merchant
```
## Author

**Mohamed Nabil**

- <https://www.linkedin.com/in/mohamed-nabil-a184125b>
- <https://github.com/mohamednabil00000>
- <https://leetcode.com/mohamednabil00000/>
