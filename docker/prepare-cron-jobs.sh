#! /bin/sh

# update cron jobs
bundle exec whenever --update-crontab

echo "cron jobs updated successfully!"
