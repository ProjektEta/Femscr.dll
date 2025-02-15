mouse1click = mouse1click or nil
mousemoveabs = mousemoveabs or nil

local s = true
local function loop() 
    local event = game.Players.LocalPlayer

    local s,e = pcall(function()
        for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("Tool") then event = v end
        end
    
        event.events.cast:FireServer(100, 1)
    end)
    if e then
        warn("No fishing rod equipped!")
        return;
    end

    local ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("shakeui")
    repeat
        ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("shakeui")
        task.wait()
    until ui
    
    repeat
        if ui:FindFirstChild("safezone") then
            if ui.safezone:FindFirstChild("button") then
		if mouse1click and mousemoveabs then
		    mousemoveabs(ui.safezone:FindFirstChild("button").AbsolutePosition.X + 60, ui.safezone:FindFirstChild("button").AbsolutePosition.Y + 80)
                    mouse1click()
		end
            end
        end
        task.wait()
    
        ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("shakeui")
        if not (ui) then ui = false end
    until not ui
    print("Shake ui disappeared")

    local bounceBack = 0
    
    ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("reel")
    repeat
       task.wait(.1)
       ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("reel") 
       bounceBack += 1
       if bounceBack >= 20 then
            print("protection")
            return;
       end
       
    until ui
    print("Found Reel UI")
    
    repeat
        task.wait()
        if ui:FindFirstChild("bar") then
            local b = ui:FindFirstChild("bar")
            if b:FindFirstChild("fish") and b:FindFirstChild("playerbar") then
                b:FindFirstChild("playerbar").Position = b:FindFirstChild("fish").Position
            end
        end
    
        ui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("reel") 
        if not (ui) then ui = false end
    until not ui
    
    print("Finished!")
end


local function autofarmLoop()

    while true do
        if s then
            loop()
        end
        task.wait(2)
    end

end

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

OrionLib:MakeNotification({
	Name = "FemScr",
	Content = "Join our disocrd! .gg/x4RfPQZvs2",
	Image = "rbxassetid://4483345998",
	Time = 5
})

if setclipboard then
    setclipboard("https://discord.gg/x4RfPQZvs2")
end
autofarmLoop()
