local Types = require(game.ReplicatedStorage.Shared.Types)

local theme: Types.Theme = {
	Colors = {
		Background = Color3.fromHex("#161615"),
		Surface = Color3.fromHex("#262322"),
		Primary = Color3.fromHex("#000"),
        Secondary = Color3.fromHex("#000"),
        Error = Color3.fromHex("#000"),

        OnBackground = Color3.fromHex("#ffeddb"),
        OnSurface = Color3.fromHex("#f9dbbd"),
        OnPrimary = Color3.fromHex("#ffffff"),
        OnSecondary = Color3.fromHex("#ffffff"),
        OnError = Color3.fromHex("#ffffff"),
	},
	Fonts = {
		Primary = Font.fromEnum(Enum.Font.Roboto)
	}
}

return theme