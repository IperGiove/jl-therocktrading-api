# The Rock Trading Julia Library 
*TheRockTrading Julia Library to communicate with JSON REST API (current version -> v1)*


# Features
- Official implementation
- Place orders
- Wallet managment 
- Market data


## Installation

julia:
```sh
pkg> using TheRockTrading
```

## Quickstart

Register an account with [The Rock Trading](https://www.therocktrading.com/)
or [The Rock Trading Staging](https://www.staging-therocktrading.com/).

Go to settings page and get the API and APY SECRET keys.
If you want to use the staging set `staging=True`.

```julia
using TheRockTrading

client = TheRockTrading.Client(API='API', API_SECRET='API_SECRET', staging=false)

println(TheRockTrading.currencies(client))
```

# Examples
...

You can find the full documentation for the endpoints [here](https://api.therocktrading.com/doc/v1/index.html#api-Account_API-Currency_withdraw_limits)
