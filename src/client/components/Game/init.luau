local TouchInputService = game:GetService("TouchInputService")
local UserInputService = game:GetService("UserInputService")
local Calculations = require(script.Calculations)
local React = require(game.ReplicatedStorage.Packages.React)
local Types = require(game.ReplicatedStorage.Shared.Types)
local Theme = require(script.Parent.Theme)
local Padding = require(script.Parent.Padding)
local TileComponent = require(script.Tile)

local e = React.createElement

type Tile = Types.Tile

function generateBoard(width: number, height: number, bombCount: number): Types.Board
    local grid: {{Tile}} = {}
	for x = 1, width do
		grid[x] = {}
		for y = 1, height do
			grid[x][y] = {
                revealed = false,
                isBomb = false,
                detonated = false,
                modification = "none"
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

function GameComponent(props: {Width: number, Height: number, Size: number, Padding: number, Skin: Types.Skin})
    local theme = React.useContext(Theme.Context)
    local tileState, setTileState = React.useState(generateBoard(props.Width, props.Height, 10))
    local mouseDown, setMouseDown = React.useState(false)

    local playing, setPlaying = React.useState(true)

    local function bombCallback(Location: Vector2)
		local tileStateClone = Calculations.DeepCopy(tileState)
        tileStateClone[Location.X][Location.Y].detonated = true
		print("hit bomb")
		setTileState(tileStateClone)
        setPlaying(false)
    end

    local tiles: {React.ReactNode} = {}
    local i = 0
    for x = 1, props.Width do
        for y = 1, props.Height do
			i += 1
            table.insert(tiles, e(TileComponent, {
                skin = props.Skin,
                nearbyBombs = Calculations.GetNearbyBombCount(tileState, Vector2.new(x, y)),
                tileData = tileState[x][y],
                mouseDown = playing and mouseDown, 
                onClick = function()
                    if not playing then
                        return
                    end
				    local tileStateClone = Calculations.DeepCopy(tileState)
                    if tileState[x][y].modification == "flag" then
                        return
                    end
                    if tileState[x][y].revealed then
                        Calculations.Chord(tileStateClone, Vector2.new(x, y), bombCallback)
                    end
                    print(`click! {x}, {y}`) 
                    Calculations.Discover(tileStateClone, Vector2.new(x, y), bombCallback)
                    setTileState(tileStateClone)
                end,
                onSecondary = function()
                    if not playing then
                        return
                    end
                    local tileStateClone = Calculations.DeepCopy(tileState)
                    if tileState[x][y].revealed then
                        return
                    end
                    if tileState[x][y].modification == "flag" then
                        tileStateClone[x][y].modification = "question"
                    elseif tileState[x][y].modification == "question" then
                        tileStateClone[x][y].modification = "none"
                    else
                        tileStateClone[x][y].modification = "flag"
                    end
                    print(`new state: {tileStateClone[x][y].modification}`)
                    setTileState(tileStateClone)
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