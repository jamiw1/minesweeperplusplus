local UserInputService = game:GetService("UserInputService")
local React = require(game.ReplicatedStorage.Packages.React)
local Theme = require(script.Parent.Theme)
local Padding = require(script.Parent.Padding)
local TileComponent = require(script.Tile)

local e = React.createElement

type Tile = {
    currentState: "unrevealed" | "revealed" | "flagged",
    isBomb: boolean,
}

function generateBoard(width: number, height: number, bombCount: number): {{Tile}}
    local grid: {{Tile}} = {}
	for x = 1, width do
		grid[x] = {}
		for y = 1, height do
			grid[x][y] = {
                currentState = "unrevealed",
                isBomb = false
            }
		end
	end
    local i = 0
    while i < bombCount do
        local x = math.random(1, width)
        local y = math.random(1, height)
        if not grid[x][y].isBomb then
            grid[x][y].isBomb = true
            i += 1
        end
    end

    return grid
end

function GameComponent(props: {Width: number, Height: number, Size: number, Padding: number})
    local theme = React.useContext(Theme.Context)
    local tileState, setTileState = React.useState(generateBoard(props.Width, props.Height, 10))
    local mouseDown, setMouseDown = React.useState(false)

    local tiles: {React.ReactNode} = {}
    local i = 0
    for x = 1, props.Width do
        for y = 1, props.Height do
			i += 1
            table.insert(tiles, e(TileComponent, {
                mouseDown = mouseDown, 
                onClick = function() 
                    print(`click! {x}, {y}`) 
                end,
                index = i
            }))
        end
    end

    React.useEffect(function()
        setTileState(generateBoard(props.Width, props.Height, 10))
    end, {props.Width, props.Height})
    React.useEffect(function()
        local connection1 = UserInputService.InputBegan:Connect(function(io, gpe)
            if io.UserInputType == Enum.UserInputType.MouseButton1 then
                setMouseDown(true)
            end
        end)

		local connection2 = UserInputService.InputEnded:Connect(function(io, gpe)
			if io.UserInputType == Enum.UserInputType.MouseButton1 then
				setMouseDown(false)
			end
		end)
        return function()
            connection1:Disconnect()
            connection2:Disconnect()
        end
    end, {})

    return e("Frame", {
        Size = UDim2.fromOffset((props.Size * props.Width) + (props.Padding * 2), (props.Size * props.Height) + (props.Padding * 2)),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = theme.Colors.Surface,
    }, {
        Layout = e("UIGridLayout", {
            CellSize = UDim2.fromOffset(props.Size, props.Size),
            CellPadding = UDim2.fromOffset(0, 0),
            SortOrder = Enum.SortOrder.LayoutOrder,
            FillDirection = Enum.FillDirection.Vertical,
            FillDirectionMaxCells = props.Width
        }),
        Padding = e(Padding, {Offset = props.Padding}),
        Corner = e("UICorner", {CornerRadius = UDim.new(0, props.Padding)}),
        Tiles = e(React.Fragment, {}, tiles)
    })
end

return GameComponent