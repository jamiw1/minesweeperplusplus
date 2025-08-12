local React = require(game.ReplicatedStorage.Packages.React)
local Theme = require(script.Parent.Theme)
local Padding = require(script.Parent.Padding)

local e = React.createElement

function game()
    local theme = React.useContext(Theme.Context)

    return e("Frame", {
        Size = UDim2.fromOffset(400, 400),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = theme.Colors.Surface,
    }, {
        Layout = e("UIGridLayout"),
        Padding = e(Padding, {Offset = 10}),
        Corner = e("UICorner", {CornerRadius = UDim.new(0, 10)})
    })
end

return game