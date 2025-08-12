local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(Player: Player)
    Player.CharacterAdded:Connect(function(Character: Model)
        local hrp = Character:WaitForChild("HumanoidRootPart") :: BasePart
        hrp.Anchored = true
    end)
end)
