include("./client_config.jl")
using client_config


"""
Get all currencies info.
"""
function currencies(client::Client) :: Tuple{Dict{String, Any}, Int16}
    url = url_creator(client, "/currencies")
    return requests_and_parse("GET", url)
end


"""
Get all currencies info.
"""
function balance(client::Client, fund_id::String) :: Tuple{Dict{String, Any}, Int16}
    url = url_creator(client, "/balance/$fund_id")
    return requests_and_parse("GET", url)
end
