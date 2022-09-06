using TheRockTrading
using Test

@testset "TheRockTrading.jl" begin
    
    client = TheRockTrading.Client(ENV["TRT_API"], ENV["TRT_API_SECRET"])
    
    dict_data, status = TheRockTrading.ohlc_statistics(client, fund_id="BTCEUR", sort="ASC")
    println(dict_data, typeof(dict_data), status)
end
