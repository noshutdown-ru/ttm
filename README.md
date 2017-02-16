# TTM

Is a plugin for project management Redmine.
Allows you to create a subscription for the various activities and keep records of customer service.

## About

https://noshutdown.ru/en/redmine-plugins-ttm/#about

## Instalaltion

```
# cd redmine/plugins 
# git clone https://github.com/noshutdown-ru/ttm.git
# cd ../
# bundle install --without development test
# rake redmine:plugins:migrate RAILS_ENV=production
```

* **For sending reminders (e-mail) about the low level of subscription balance**: ``` RAILS_ENV=production rake redmine:plugins:ttm:notify``` **in redmine root.**

Read more: https://noshutdown.ru/en/redmine-plugins-ttm/#install

## [REST API](RESTAPI.md)

## Screenshots

https://noshutdown.ru/en/redmine-plugins-ttm/#screens

## Releases info

https://noshutdown.ru/en/redmine-plugins-ttm/#releases
