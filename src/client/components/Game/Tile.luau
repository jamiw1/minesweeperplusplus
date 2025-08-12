local React = require(game.ReplicatedStorage.Packages.React)
local e = React.createElement

return function(props: {
    mouseDown: boolean, 
    onClick: () -> (),
    index: number,
})
	local hovering, setHovering = React.useState(false)
	local pressing = props.mouseDown and hovering
    local tileRef = React.useRef(nil)

    React.useEffect(function()
        local connection1
        local connection2
        if tileRef.current then
            connection1 = tileRef.current.MouseEnter:Connect(function()
                setHovering(true)
            end)
			connection2 = tileRef.current.MouseLeave:Connect(function()
				setHovering(false)
			end)
        end

        return function()
            if connection1 then
                connection1:Disconnect()
            end
            if connection2 then
                connection2:Disconnect()
            end
        end
    end, {tileRef.current})

    return e("ImageButton", {
        ImageTransparency = 1,
        AutoButtonColor = false,
        BackgroundColor3 = (pressing and hovering) and Color3.new(0,0,0) or Color3.new(1,1,1),
        LayoutOrder = props.index,
        ref = tileRef,
        [React.Event.MouseButton1Up] = props.onClick
    }, {
    })
end
