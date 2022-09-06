module TheRockTrading

include("./client_config.jl")

"""
Get single currency info

Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function currency(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/currencies/$fund_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get all currencies info.
"""
function currencies(
    client::Client
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/currencies")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get your balance in a specific currency.
    
Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function balance(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/balances/$fund_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get a list of all your balances in any currency.
"""
function balances(
    client::Client
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/balances")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get user's addresses per currency.

Parameters Mandatory:
- fund_id -> string: fund symbol

Parameters Optional:
- direction -> String: filter addresses by direction. Accepted values are 'deposit' or 'withdraw'
- network -> String: filter addresses by network. Accepted values are 'bitcoin', 'litecoin', ...
- bech32 -> Booelan: filter addresses to get bech32 addresses only. 
                        Option accepted combined with 'BTC' currency only
- transparent -> Boolean: filter addresses to get transparent addresses only. 
                            Option accepted combined with 'ZEC' currency only
- private -> Boolean: filter addresses to get private addresses only. 
                        Option accepted combined with 'ZEC' currency only
- unused -> Boolean: filter addresses in order to get yet used addresses. 
                        Option accepted combined with 'deposit' direction only
- per_page -> Integer: number of addresses per page. default 25 max 200
- page -> Integer: page number. default 1
"""
function currencies_adresses(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/currencies/$fund_id/addresses")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Submit a new address generation request for a currency. 
A new address request returns no data if succeeds.

Parameters Mandatory:
- fund_id -> string: fund symbol

Parameters Optional:
- network -> String: Network on which you are requesting a new address. 
            Accepted values are 'bitcoin', 'litecoin', ...
- segwit -> Boolean: Set to true in order to request a segwit address generation [default]. 
            Parameter accepted when combined with BTC currency only.
- bech32 -> Booelan: Set to true in order to request a bech32 address generation.
            Option accepted combined with 'BTC' currency only
- transparent -> Boolean: Set to true in order to request a transparent address generation [default].
            Option accepted combined with 'ZEC' currency only
- private -> Boolean: Set to true in order to request a private address generation.
            Option accepted combined with 'ZEC' currency only
- confidential ->  Boolean: Set to true in order to request a confidential address generation. 
            Parameter accepted when combined with BTC currency and 'liquid' network only.
"""
function new_deposit_address(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/currencies/$fund_id/addresses")
    header = header_creator(client=client, url=url)
    return requests_and_parse("POST", url, header, query=Dict(kwargs))
end


"""
Show your transaction by ID.

Parameters Mandatory:
- transaction_id -> Integer: transaction id
"""
function transaction(
    client::Client; transaction_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/transactions/$transaction_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get user's transactions

Parameters Optional:
- page -> Integer: page number. default 1
- fund_id -> String: filter transactions by fund symbol
- currency -> String: filter transactions by currency
- after -> String: filter transactions after a certain timestamp 
                    (format %Y-%m-%dT%H:%M:%S%Z ex. 2015-02-06T08:47:26Z )
- before -> String: filter transactions before a certain timestamp 
                    (format %Y-%m-%dT%H:%M:%S%Z )
- type -> String: filter transactions by transaction type
- order_id -> String: filter transactions by a specific order ID
- trade_id -> String: filter transactions by a specific trade ID
- transfer_method -> String: filter transactions by transfer method. 
                                Accepted methods are: wire_transfer, ripple, 
                                greenaddress, bitcoin, litecoin, namecoin, 
                                peercoin, dogecoin
- transfer_recipient -> String: filter transactions by a specific recipient 
                                (e.g. Bitcoin address, IBAN)
- transfer_id ->  String: filter transactions by a specific transfer ID 
                            (e.g. Bitcoin TX hash)
"""
function transactions(
    client::Client; kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/transactions")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


"""
Returns currency related discount

Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function discount(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/discounts/$fund_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Returns currencies related discount
"""
function discounts(
    client::Client
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/discounts")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Return a currency related withdraw limit

Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function withdraw_limit(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/withdraw_limit/$fund_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Return a list of your global and currently available withdraw levels.
"""
function withdraw_limits(
    client::Client
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/withdraw_limits")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Return a list of your global and currently available withdraw levels.

Parameters Mandatory:
- currency -> String: Currency you want to withdraw
- amount -> Float: Withdrawal amount
- destination_address -> String: Destination address

Parameters Optional:
- withdraw_method -> String: The withdraw method to be used. 
                    A default method will be applied if not specified. 
                    Alternative withdrawal methods accepted are 'RIPPLE', 'LIQUID', 'LIGHTNING'
- withdraw_priority -> String: Options are 'regular' (default), 'high'. 
                    Regular priority withdrawals are grouped and executed within 15 minutes. 
                    High priority withdrawals are executed immediately. 
                    Check on therocktrading.com page how fees are respectively applied. 
                    Currently available for bitcoin withdrawals only.
- destination_tag -> Integer: Destination tag useful when combined with RIPPLE withdrawal method
"""
function withdraw(
    client::Client; amount::Number, currency::String, destination_address::String,
    kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    mandatory_params = Dict(
        :amount => amount,
        :currency => currency,
        :destination_address => destination_address
    )
    
    url = url_creator(client, "/atms/withdraw")
    header = header_creator(client=client, url=url)
    return requests_and_parse("POST", url, header, query=merge(Dict(kwargs), mandatory_params))
end

"""
Close all open positions originated by a specific order ID
    
Parameters Mandatory:
- fund_id -> string: fund symbol
- order_id -> String: order ID
"""
function close_at_market(
    client::Client; fund_id::String, order_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/currencies/$fund_id/main_positions/$order_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("DELETE", url, header)
end


"""
List your margin positions grouped by originating order ID (opening order).

Parameters Mandatory:
- fund_id -> string: fund symbol

Parameters Optional:
- status -> String: filter main positions by status. Accepted values are: open, closed
- type -> String: filter main positions by type. Accepted values are: short, long
- page -> Integer: page number. default 1
"""
function positions_list(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/currencies/$fund_id/main_positions")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


"""
Show specific position.

Parameters Mandatory:
- fund_id -> string: fund symbol
- order_id -> String: order ID
"""
function position_show(
    client::Client; fund_id::String, order_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/main_positions/$order_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Transfer the amount of base currency required by maintenance_balance 
(See showMainPosition API doc for further infomation ) to close a position. 
It applies only to short positions when the amount of base currency is not sufficient to close them.

Parameters Mandatory:
- amount -> String: the amount you want to transfer
- currency -> String: base currency operating on the fund. (e.g. fund: BTCEUR -> base_currency: EUR)
"""
function transfer_balance(
    client::Client; fund_id::String, order_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/main_positions/$order_id/transfer_balance")
    header = header_creator(client=client, url=url)
    return requests_and_parse("POST", url, header)
end


"""
An overall view of margin trading personal balances, both base and trade currency, for each fund/currency pairs. 
Position balance is part of the regular user balances, but it is related to margin trading. 
For example, you have to refer to position balance in order to see if and how you can close a position. 
This api will return the sum of all your positions balances.

Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function position_balances(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/position_balances")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
List your margin positions.

Parameters Optional:
- status -> String: filter positions by status. Accepted values are: open, closed
- type -> String: filter positions by type. Accepted values are: short, long
- page -> Integer: page number. default 1
"""
function positions(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/position_balances")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


"""
Get all fair value by currency

Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function fair_value(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/fair_values/$fund_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get single fund data.

Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function fund(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get all funds at once.
"""
function funds(
    client::Client
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get all fair values
"""
function fair_value(
    client::Client
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/fair_values")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get Open-high-low-close chart statistics.

Parameters Mandatory:
- fund_id -> String: fund symbol

Parameters Optional:
- period -> String: Sampling period in minutes. Default: 15, Min: 5
- before -> Date: Get only trades executed before a certain timestamp ( format %Y-%m-%dT%H:%M:%S%Z ). 
            Must be a multiple of 'period' minutes. Default: now().
- after -> Date: Get only trades executed after a certain timestamp ( format %Y-%m-%dT%H:%M:%S%Z). 
            Must be a multiple of 'period' minutes. Default is one day behind "before"
- sort -> String: Accepted values are: ASC|DESC. Default: DESC
"""
function ohlc_statistics(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/ohlc_statistics")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


"""
The orderbook api will provide the entire/partial set of bids and asks for a specific currency pair (fund).

Parameters Mandatory:
- fund_id -> string: fund symbol

Parameters Optional:
- limit -> Integer: max number of entries to return for each side (asks and bids)
- currency_for_depth -> String: currency on which to apply a depth filter
- depth -> String: generic depth filter to apply to both asks and bids
- ask_depth -> String: ask depth filter to apply to asks entries only 
                        (generic depth param will be applied if not specified)
- bid_depth -> String: bid depth filter to apply to bids entries only
                        (generic depth param will be applied if not specified)
"""
function orderbook(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/orderbook")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


"""
Get ticker of a choosen fund.

Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function ticker(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/ticker")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get all tickers at once.
"""
function tickers(
    client::Client
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/tickers")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get all trades.

Parameters Mandatory:
- fund_id -> string: fund symbol

Parameters Optional:
- trade_id -> Integer: get all trades starting from a specific trade_id
- per_page -> Integer: number of trades per page. default 25 max 200
- page -> Integer: page number. default 1
- after -> String: get only trades executed after a certain timestamp 
                    (format %Y-%m-%dT%H:%M:%S%Z ex. 2015-02-06T08:47:26Z)
- before -> String: get only trades executed before a certain timestamp
                    (format %Y-%m-%dT%H:%M:%S%Z )
- order -> String: order trades by id. Accepted values are: ASC|DESC. Default: DESC
"""
function trades(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/trades")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


"""
Remove all active orders from the specified market.

Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function cancel_all_orders(
    client::Client; fund_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/orders/remove_all")
    header = header_creator(client=client, url=url)
    return requests_and_parse("DELETE", url, header)
end


"""
Remove an active order from the specified market.

Parameters Mandatory:
- fund_id -> string: fund symbol
- order_id -> string: the id of the order to be cancelled.
"""
function cancel_all_orders(
    client::Client; fund_id::String, order_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/orders/$order_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("DELETE", url, header)
end


"""
List your orders per fund_id. All active or conditional orders are returned by default.

Parameters Mandatory:
- fund_id -> String: fund symbol

Parameters Optional:
- after -> String: filter orders after a certain timestamp 
                        (format %Y-%m-%dT%H:%M:%S%Z ex. 2015-02-06T08:47:26Z)
- before -> String: filter orders before a certain timestamp 
                        (format %Y-%m-%dT%H:%M:%S%Z )
- status -> String: filter orders by status. Accepted values are: active, conditional, executed and deleted
- side -> String: filter orders by side. Accepted values are: buy, sell
- position_id -> Integer: filter orders by margin position ID. It collects all closing orders related to a specific margin position ID
"""
function orders(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/orders")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


"""
Place an order on the specified market, at specified conditions.

Parameters Mandatory:
- fund_id -> String: fund symbol
- side -> String: "buy" or "sell" order. "close_long" or "close_short" to place a closing position order 
                (position_id or position_order_id parameter required).
- amount -> String: the amount you want to Buy/Sell
- price -> String: the price of your order to be filled. If price is 0 (zero) a market order will be placed.

Parameters Optional:
- conditional_type -> String: specify a conditional type in order to place a conditional order. 
                                Accepted values are [stop_loss|take_profit]
- conditional_price -> String: conditional price represent the price at which your order will be triggered. 
                                Need to be specified when conditional_type param is present.
- leverage -> String: leverage to apply on "buy" or "sell" orders only. 
                                Leverage values are configured per fund. See fund API doc for further information.
- position_id -> String: position_id along with "close_long" or "close_short" parameter in order to close a single position.
- position_order_id -> String: position_order_id along with "close_long" or "close_short" as an alternative to position_id parameter
                                in order to close all open positions originated by the same leveraged order.
"""
function place_order(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/orders")
    header = header_creator(client=client, url=url)
    return requests_and_parse("POST", url, header, query=Dict(kwargs))
end


"""
Show your order by ID.

Parameters Mandatory:
- fund_id -> String: fund symbol
- order_id -> String: order ID
"""
function show_order(
    client::Client; fund_id::String, order_id::String
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/orders/$order_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Show your order by ID.

Parameters Mandatory:
- fund_id -> String: fund symbol

Parameters Optional:
- trade_id -> Integer: get all trades starting from a specific trade_id
- page -> Integer: page number. default 1
- per_page -> Integer: number of trades per page. default 25 max 200
- after -> String: get only trades executed after a certain timestamp 
                    (format %Y-%m-%dT%H:%M:%S%Z ex. 2015-02-06T08:47:26Z)
- before -> String: get only trades executed before a certain timestamp 
                    (format %Y-%m-%dT%H:%M:%S%Z)
"""
function user_trades(
    client::Client; fund_id::String, kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    url = url_creator(client, "/funds/$fund_id/trades")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


end