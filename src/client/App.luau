local React = require(game.ReplicatedStorage.Packages.React)
local Theme = require(script.Parent.components.Theme)

local GameComponent = require(script.Parent.components.Game)

local e = React.createElement

function App()
    local theme = React.useContext(Theme.Context)

    return e(React.Fragment, {}, {
        Background = e("ScreenGui", {IgnoreGuiInset = true, DisplayOrder = -100}, {
            e("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = theme.Colors.Background, BorderSizePixel = 0})
        }),
        Game = e("ScreenGui", {}, {
            e(GameComponent, {})
        })
    })
end

return App