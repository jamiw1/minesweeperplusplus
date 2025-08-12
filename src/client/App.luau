local React = require(game.ReplicatedStorage.Packages.React)
local e = React.createElement

function App()
    return e("Frame", {
        Size = UDim2.fromScale(1, 1)
    })
end

return App