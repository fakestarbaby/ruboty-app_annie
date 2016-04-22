# Ruboty::AppAnnie

Manage App Annie via Ruboty.

## Install

```ruby
# Gemfile
gem "ruboty-app_annie"
```

## Usage

### Accounts API

```
@ruboty annie list accounts - Retrieve all account connections available in an App Annie user account
@ruboty annie list products of <account_id> - Retrieve the product list of an Analytics Account Connection
@ruboty annie list {ios|android} reviews of <product_id> from <start_date> to <end_date> in <country> - Retrieve one product’s reviews
@ruboty annie list {ios|android} reviews of <product_id> days ago <days_ago> in <country> - Retrieve one product’s reviews of days ago
```

## ENV

```
APP_ANNIE_API_KEY - App Annie API Key
```
