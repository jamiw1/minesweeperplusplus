local Types = require(script.Parent.Types)
local Skins = {}

type Skin = Types.Skin

function deepCopy(input: { [any]: any }): { [any]: any }
	local newTable = {}
	for key, value in input do
		if typeof(value) == "table" then
			newTable[key] = deepCopy(value)
		else
			newTable[key] = value
		end
	end
	return newTable
end

function join(fallback: { [any]: any }, content: { [any]: any }): { [any]: any }
	local new = deepCopy(fallback)
	for key, value in content do
        local fallbackValue = new[key]
		if typeof(fallbackValue) == "table" and typeof(value) == "table" then
			new[key] = join(fallbackValue, value)
		else
			new[key] = value
		end
	end
	return new
end

local skinList: { [string]: Skin } = {}
local DefaultSkin = require(script.Default)
for _, skin in ipairs(script:GetChildren()) do
	local success, result = pcall(function()
		return require(skin) :: Skin?
	end)
	if success then
		skinList[skin.Name] = join(DefaultSkin, result :: Skin)
	else
		warn(result)
	end
end

function Skins.getSkin(name: string): Skin
    if skinList[name] then
        return skinList[name]
    end
    return skinList.Default -- use Default as a fallback
end



return Skins