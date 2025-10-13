local supportGame = {
    AE = 7882829745,
}

-- Đợi game load :|
if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.GameId == supportGame.AE then
    getenv().isRunByHub = true
    getenv().GameName = "AnimeEternal"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/QBGamer/AE/refs/heads/main/AnimeEternal.lua"))()
else
    warn("QBHub: Game not supported!")
end