# 🕐 TTM - Time To Money

A Redmine plugin for managing service subscriptions with time tracking and cost analysis.

## Features

- 📋 Create and manage subscriptions for activities
- ⏱️ Track time spent on subscriptions
- 💰 Calculate costs based on hourly rates
- 📊 View subscription status (Active, Pending, Closed, Used Up)
- ⏲️ Add extra hours to subscriptions
- 📧 Email notifications for low subscription balance
- 🌐 REST API for integration
- 🔍 Global subscription overview across all projects

## Installation

```bash
cd redmine/plugins
git clone https://github.com/noshutdown-ru/ttm.git
cd ../
bundle install --without development test
rake redmine:plugins:migrate RAILS_ENV=production
```

## Configuration

### Enable Email Notifications

To send reminders about low subscription balance, run this in Redmine root:

```bash
RAILS_ENV=production rake redmine:plugins:ttm:notify
```

Configure this as a cron job to run regularly:
```bash
0 9 * * * cd /path/to/redmine && RAILS_ENV=production rake redmine:plugins:ttm:notify
```

## Usage

### Web Interface

1. **Create Subscription**: Go to project → Subscriptions → New Subscription
   - Set activity, tracker, dates, hours, and rate
   - Optionally add notification email

2. **View Subscription**: See details, time entries, and extra hours
   - Filter by date range
   - View spent hours and remaining balance

3. **Add Extra Hours**: Use "Add Extra-Time" to extend subscription hours

4. **Global View**: Admin menu → Subscriptions for overview across all projects
   - Filter by project, ID, name, activity, tracker, status

### [API](API.md)

