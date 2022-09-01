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
Get all currencies info.
"""
function balance(client::Client, fund_id::String) :: Tuple{Dict{String, Any}, Int16}
    url = url_creator(client, "/balance/$fund_id")
    header = header_creator(client=client, url=url)
    return requests_and_parse("GET", url, header)
end


end
