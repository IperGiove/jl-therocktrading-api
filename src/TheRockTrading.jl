module TheRockTrading

include("./client_config.jl")


"""
Get all currencies info.
"""
function currencies(client::Client) :: Tuple{Dict{String, Any}, Int16}
    url = url_creator(client, "/currencies")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get your balance in a specific currency.
    
Parameters Mandatory:
- fund_id -> string: fund symbol
"""
function balance(client::Client, fund_id::String) :: Tuple{Dict{String, Any}, Int16}
    url = url_creator(client, "/balances/$fund_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


"""
Get a list of all your balances in any currency.
"""
function balances(client::Client) :: Tuple{Dict{String, Any}, Int16}
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
function currencies_adresses(client::Client, fund_id::String) :: Tuple{Dict{String, Any}, Int16}
    url = url_creator(client, "/currencies/$fund_id/addresses")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
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
function positions_list(client::Client, fund_id::String) :: Tuple{Dict{String, Any}, Int16}
    url = url_creator(client, "/currencies/$fund_id/addresses")
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
    client::Client, fund_id::String; kwargs...
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    url = url_creator(client, "/funds/$fund_id/ohlc_statistics")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header, query=Dict(kwargs))
end


end
