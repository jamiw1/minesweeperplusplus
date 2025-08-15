local ImageOffset = {}

export type TileState = "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "0" | "Blank" | "Flag" | "NotBomb" | "QuestionPress" | "Question" | "Bomb" | "HitBomb"
ImageOffset.tileGrid = {
    ["1"] = Vector2.new(0,0),
    ["2"] = Vector2.new(1,0),
    ["3"] = Vector2.new(2,0),
    ["4"] = Vector2.new(3,0),
    ["5"] = Vector2.new(0,1),
    ["6"] = Vector2.new(1,1),
    ["7"] = Vector2.new(2,1),
    ["8"] = Vector2.new(3,1),
    ["0"] = Vector2.new(0,2),
    Blank = Vector2.new(1,2),
    Flag = Vector2.new(2,2),
    NotBomb = Vector2.new(3,2),
    QuestionPress = Vector2.new(0,3),
    Question = Vector2.new(1,3),
    Bomb = Vector2.new(2,3),
    HitBomb = Vector2.new(3,3),
} :: {[TileState]: Vector2}

function ImageOffset.getTileOffset(tileState: TileState, tileSize: number): Vector2
    return ImageOffset.tileGrid[tileState] * tileSize
end

return ImageOffset