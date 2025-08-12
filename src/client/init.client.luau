local React = require(game.ReplicatedStorage.Packages.React)
local ReactRoblox = require(game.ReplicatedStorage.Packages.ReactRoblox)
local Theme = require(script.components.Theme)

local App = require(script.App)

local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player.PlayerGui

local e = React.createElement

local tree = ReactRoblox.createRoot(Instance.new("Folder"))
tree:render(ReactRoblox.createPortal(
    e(React.StrictMode, {}, {
        e(Theme.Context.Provider, {value = Theme.Default}, {
            e(App)
        })
    })    
, PlayerGui))
