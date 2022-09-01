using TheRockTrading
using Test

@testset "TheRockTrading.jl" begin
    
    client = TheRockTrading.Client("API","API_SECRET")
    
    println(TheRockTrading.currencies(client))
    #TheRockTrading.test()
end
