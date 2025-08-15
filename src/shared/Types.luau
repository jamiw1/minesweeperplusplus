export type Theme = {
    Colors: {
        Background: Color3,
        Surface: Color3,
        Primary: Color3,
        Secondary: Color3,
        Error: Color3,

        OnBackground: Color3,
        OnSurface: Color3,
        OnPrimary: Color3,
        OnSecondary: Color3,
        OnError: Color3,
    },
    Fonts: {
        Primary: Font
    }
}

export type Skin = {
	Tiles: string,
    TileSize: number,
	Smileys: string,
    SmileySize: number,

    Aliased: boolean,

	Sounds: {
        TileDown: string,
        TileUp: string,

        Chord: string,

        PlaceFlag: string,
        RemoveFlag: string,

        Win: string,
        Lose: string
    },
}

export type Tile = {
	revealed: boolean,
	isBomb: boolean,
    modification: "none" | "flag" | "question",
    detonated: boolean
}

export type Board = {{Tile}}

return {}