local React = require(game.ReplicatedStorage.Packages.React)
local ThemeTypes = require(game.ReplicatedStorage.Shared.ThemeTypes)

local Theme = {}
Theme.Default = require(game.ReplicatedStorage.Shared.DefaultTheme)
Theme.Context = React.createContext(Theme.Default) :: React.Context<ThemeTypes.Theme>

return Theme