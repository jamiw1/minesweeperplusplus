local React = require(game.ReplicatedStorage.Packages.React)
local e = React.createElement

return function(props: {Scale: number?, Offset: number?})
    local Scale = props.Scale or 0
    local Offset = props.Offset or 0

    return e("UIPadding", {
        PaddingBottom = UDim.new(Scale, Offset),
        PaddingLeft = UDim.new(Scale, Offset),
        PaddingRight = UDim.new(Scale, Offset),
        PaddingTop = UDim.new(Scale, Offset),
    })
end
