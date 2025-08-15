local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Types = require(ReplicatedStorage.Shared.Types)
local Calculations = {}

local tileDirections = {
    Vector2.new(-1, -1),
    Vector2.new(0, -1),
    Vector2.new(1, -1),

    Vector2.new(-1, 0),
    Vector2.new(1, 0),

    Vector2.new(-1, 1),
    Vector2.new(0, 1),
    Vector2.new(1, 1),
}

function Calculations.GetNearbyBombCount(Board: Types.Board, Location: Vector2): number
    local bombCount = 0
    for _, offset in ipairs(tileDirections) do
        local newloc = Location + offset
        if Board[newloc.X] then
            if Board[newloc.X][newloc.Y] then
                bombCount += Board[newloc.X][newloc.Y].isBomb and 1 or 0
            end
        end
    end
    return bombCount
end

function Calculations.GetNearbyFlagCount(Board: Types.Board, Location: Vector2): number
	local flagCount = 0
	for _, offset in ipairs(tileDirections) do
		local newloc = Location + offset
		if Board[newloc.X] then
			if Board[newloc.X][newloc.Y] then
				flagCount += Board[newloc.X][newloc.Y].modification == "flag" and 1 or 0
			end
		end
	end
	return flagCount
end

function Calculations.Discover(Board: Types.Board, Location: Vector2, bombCallback: () -> ())
    if not Board[Location.X] then
        return
    end
    local tile: Types.Tile = Board[Location.X][Location.Y]
    if not tile then
        return
    end
	Board[Location.X][Location.Y].revealed = true
    if tile.isBomb then
        bombCallback()
        return
    end
    local nearbyBombCount = Calculations.GetNearbyBombCount(Board, Location)
    if nearbyBombCount ~= 0 then
        return
    end

	for _, offset in ipairs(tileDirections) do
        local newLocation = Location + offset
        if Board[newLocation.X] then
            if Board[newLocation.X][newLocation.Y] then
                if not Board[newLocation.X][newLocation.Y].revealed then
					Calculations.Discover(Board, newLocation, bombCallback)
                end
            end
        end
	end
end

function Calculations.Chord(Board: Types.Board, Location: Vector2, bombCallback: () -> ())
	if not Board[Location.X] then
		return
	end
	local tile: Types.Tile = Board[Location.X][Location.Y]
	if not tile then
		return
	end
	local nearbyBombCount = Calculations.GetNearbyBombCount(Board, Location)
	if nearbyBombCount == 0 then
		return
	end
    local nearbyFlagCount = Calculations.GetNearbyFlagCount(Board, Location)
    if nearbyBombCount ~= nearbyFlagCount then
        return
    end
	for _, offset in ipairs(tileDirections) do
		local newLocation = Location + offset
		if Board[newLocation.X] then
			if Board[newLocation.X][newLocation.Y] then
				if not Board[newLocation.X][newLocation.Y].revealed then
					Board[newLocation.X][newLocation.Y].revealed = true
                    if tile.isBomb then
						bombCallback()
						return
					end
                    if Calculations.GetNearbyBombCount(Board, newLocation) == 0 then
                        Calculations.Discover(Board, newLocation, bombCallback)
                    end
				end
			end
		end
	end
end

function Calculations.DeepCopy(input: { [any]: any }): { [any]: any }
	local newTable = {}
	for key, value in input do
		if typeof(value) == "table" then
			newTable[key] = Calculations.DeepCopy(value)
		else
			newTable[key] = value
		end
	end
	return newTable
end

return Calculations