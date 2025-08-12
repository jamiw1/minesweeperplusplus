local React = require(game.ReplicatedStorage.Packages.React)
local Types = require(game.ReplicatedStorage.Shared.Types)

local Theme = {}
Theme.Default = require(game.ReplicatedStorage.Shared.DefaultTheme)
Theme.Context = React.createContext(Theme.Default) :: React.Context<Types.Theme>

return Theme