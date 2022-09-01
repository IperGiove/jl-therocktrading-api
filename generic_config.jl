using Dates

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
function url_creator(url_final::String) :: String
    return url_base * url_final
end


"""
Signature header
"""
function signature_creator(message::String)
end


"""
Header creator
"""
function header(;client::Client, url::String) :: Dict
    nonce = string(time())
    return Dict{String, String}(
        "Content-Type" => "application/json", 
        "X-TRT-KEY" => client.API,
        #"X-TRT-SIGN" => signature_creator(nonce ** url),
        "X-TRT-NONCE" => nonce
    )
end


client = Client("API", "API_SECRET")
#println(client)

header(url="test", client=client)