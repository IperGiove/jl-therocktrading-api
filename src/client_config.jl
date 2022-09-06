using HTTP
using JSON
using SHA

const ENDPOINT_STAGING = "https://api-staging.therocktrading.com"
const ENDPOINT= "https://api.therocktrading.com"
const HOST = "/v1"

struct Client
    """
    Struct Client with API and API_SECRET
    """
    API::String
    API_SECRET::String
    staging::Bool
    url_base::String

    function Client(API, API_SECRET, staging=false)
        new(API, API_SECRET, staging, url_base_creator(staging))
    end
end


"""
Url base creator
"""
function url_base_creator(staging::Bool) :: String
    
    if staging
        return ENDPOINT_STAGING * HOST
    end
    return ENDPOINT * HOST
end


"""
Url creator
"""
function url_creator(client::Client, url_final::String) :: String
    return client.url_base * url_final
end


"""
Signature header
"""
function signature_creator(;client::Client, message::String)
    return String(bytes2hex(hmac_sha512(Vector{UInt8}(client.API_SECRET), Vector{UInt8}(message))))
end


"""
Header creator
"""
function header_creator(;client::Client, url::String) :: Dict
    nonce = string(trunc(Int, time() * 10000))
    return Dict{String, String}(
        "Content-Type" => "application/json", 
        "X-TRT-KEY" => client.API,
        "X-TRT-SIGN" => signature_creator(client=client, message=nonce*url),
        "X-TRT-NONCE" => nonce
    )
end

"""
Make http request and parse
"""
function requests_and_parse(
    http_method::String, url::String, header::Dict; 
    query::Union{Dict, Nothing}=nothing
    ) :: Tuple{Union{Vector{Any}, Dict{String, Any}}, Int16}
    
    r = HTTP.request(http_method, url, headers=header, query=query)
    return JSON.Parser.parse(String(r.body)), r.status
end

