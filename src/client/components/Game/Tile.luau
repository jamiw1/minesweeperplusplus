local ImageOffset = require(script.Parent.ImageOffset)
local React = require(game.ReplicatedStorage.Packages.React)
local Types = require(game.ReplicatedStorage.Shared.Types)
local e = React.createElement

local function getTileState(
    nearbyBombs: number,
    mouseDown: boolean, 
    tileData: Types.Tile
): ImageOffset.TileState
    if tileData.revealed then
		if tileData.modification == "flag" then
			return (tileData.isBomb and "Flag" or "NotBomb") :: ImageOffset.TileState
		end
        return (tileData.isBomb and "Bomb" or tostring(nearbyBombs)) :: ImageOffset.TileState
    end

    if tileData.modification == "flag" then
        return "Flag"
    end

	if tileData.modification == "question" then
		return (mouseDown and "QuestionPress" or "Question") :: ImageOffset.TileState
	end
    
    return (mouseDown and "0" or "Blank") :: ImageOffset.TileState
end

return function(props: {
    skin: Types.Skin,
    nearbyBombs: number,
    tileData: Types.Tile,
    mouseDown: boolean, 
    onClick: () -> (),
    onSecondary: () -> (),
    index: number,
})
	local hovering, setHovering = React.useState(false)
	local pressing = props.mouseDown and hovering

    return e("ImageButton", {
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        BorderSizePixel = 0,
        Image = props.skin.Tiles,
        ImageRectSize = Vector2.new(props.skin.TileSize, props.skin.TileSize),
        ImageRectOffset = ImageOffset.getTileOffset(getTileState(props.nearbyBombs, pressing, props.tileData), props.skin.TileSize),

        LayoutOrder = props.index,
        [React.Event.MouseEnter] = function()
            setHovering(true)
        end,
        [React.Event.MouseLeave] = function()
		    setHovering(false)
        end,
        [React.Event.MouseButton1Up] = props.onClick,
        [React.Event.MouseButton2Up] = props.onSecondary
    }, {})
end
