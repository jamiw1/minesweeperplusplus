local Types = require(script.Parent.Parent.Types)
local Default: Types.Skin = {
	Tiles = "rbxassetid://119174825402797",     -- spritesheet for tiles
	Smileys = "rbxassetid://84581035751952",    -- spritesheet for smileys
	TileSize = 64,                              -- square resolution of each tile
	SmileySize = 24,                            -- square resolution of each smiley
	Aliased = false,                            -- pixelated? true or false. defaults to false
	Sounds = {
		["TileDown"] = "rbxassetid://15675032796",
		["TileUp"] = "rbxassetid://5991592592",

        ["Chord"] = "rbxassetid://5991592592",

		["PlaceFlag"] = "rbxassetid://87456070060636",
		["RemoveFlag"] = "rbxassetid://6324790483",
		
		["Win"] = "rbxassetid://12222253",
        ["Lose"] = "rbxassetid://12221984",
	},
}

return Default
