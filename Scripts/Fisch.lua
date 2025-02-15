
local GuiService = game:GetService("GuiService")
local VIM = game:GetService("VirtualInputManager")
local s = true

local LockedCFrame = nil

local function loop() 
    local event = game.Players.LocalPlayer

    local s,e = pcall(function()

        for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("Tool") then event = v end
        end

        if game.Players.LocalPlayer.Character then
            if LockedCFrame == nil then
                LockedCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            else
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = LockedCFrame
            end
        end
    
        event.events.cast:FireServer(100, 1)
    end)
    if e then
        warn("No fishing rod equipped!")
        LockedCFrame = nil
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
                pcall(function()
                    GuiService.SelectedObject = ui.safezone:FindFirstChild("button")
                    if GuiService.SelectedObject == ui.safezone:FindFirstChild("button") then
                        VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
                        VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
                    end
                end)
            end
        end
        task.wait()
        GuiService.SelectedObject = nil
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

    game.ReplicatedStorage.playerstats:FindFirstChild(game.Players.LocalPlayer.Name).Inventory.ChildAdded:Connect(function(newItem)
        if (shared.UseWebhook) then
            local s,e = pcall(function()

                local Mutation = newItem:FindFirstChild("Mutation") or "NULL"
                if (typeof(Mutation) == "Instance") then Mutation = Mutation.Value end
                request({
                    Url = shared.Webhook,
                    Method = "Post",
                    Headers = {
                        ['content-type'] = "application/json",
                    },
                    Body = game:GetService("HttpService"):JSONEncode({
                        ['embeds'] = {{
                            ['title'] = "__**FEMSCR AUTO FISHER**__",
                            ['description'] = "You have caught a fish...",
                            ['type'] = "rich",
                            ['color'] = tonumber(0xffffff),
                            ['fields'] = {
                                {
                                    ["name"] = "You caught a "..newItem.Value,
                                    ["value"] = "Wighet: "..newItem:WaitForChild("Weight").Value.."KG \nMutation: "..Mutation

                                },
                                {
                                    ["name"] = game.Players.LocalPlayer.Name.." Stats",
                                    ["value"] = "C$: "..game.Players.LocalPlayer.leaderstats['C$'].Value.."\nLevel: "..game.Players.LocalPlayer.leaderstats['Level'].Value
                                },
                            },
                            ['footer'] = {
                                ['text'] = "Eta is best femboy ^^"
                            }
                        }}
                    })
                })
            end)
            if e then
                warn(e)
            end
        end
    end)

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
