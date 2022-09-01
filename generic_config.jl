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
    enc = bytes2hex(hmac_sha256(Vector{UInt8}(client.API_SECRET), message))
end


"""
Header creator
"""
function header(;client::Client, url::String) :: Dict
    nonce = string(time())
    return Dict{String, String}(
        "Content-Type" => "application/json", 
        "X-TRT-KEY" => client.API,
        "X-TRT-SIGN" => signature_creator(client=client, message=nonce*url),
        "X-TRT-NONCE" => nonce
    )
end

"""
Make http request
"""
function requests_and_parse(http_method::String, url::String) :: Tuple{Dict{String, Any}, Int16}
    r = HTTP.request(http_method, url, header=header(client=client, url=url))
    return JSON.Parser.parse(String(r.body)), r.status
end


"""
Get all currencies info.
"""
function currencies(client::Client) :: Tuple{Dict{String, Any}, Int16}
    url = url_creator(client, "/currencies")
    return requests_and_parse("GET", url)
end


if abspath(PROGRAM_FILE) == @__FILE__
    client = Client("API", "API_SECRET")
    
    println(currencies(client))
end
