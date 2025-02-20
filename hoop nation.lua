local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RevertHub/sgergwg5442tgtfd/refs/heads/main/333_334"))()


local Tabs = {
    Main = Library:addTab("", "http://www.roblox.com/asset/?id=16856644248"),
    Settings = Library:addTab("SETTINGS", "http://www.roblox.com/asset/?id=16856650102")
}

local PlaceIds = {
    Matchmaking = 16110530195,
    Park = 16347334090,
    MyCourt = 16128274392
}

--// Game Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
--//

local Main_Shooting = Tabs.Main:createGroup('left', 'Shooting');
do
    local hasShotBall = false
    Main_Shooting:addToggle({
        text = "Autotime (CONTROLLER SUPPORT)",
        default = false,
        callback = function(value)
            getgenv().AutoGreen = value

            local function autoGreen()
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Shoot"):FireServer(false, -98, true)
            end
            
            local holdingE = false
            
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
            
                if input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.ButtonX then
                    holdingE = true
                    
                    task.delay(0.5, function()
                        if getgenv().AutoGreen then
                            local isShooting = game:GetService("Players").LocalPlayer.Values.Shooting.Value
                            if isShooting and holdingE then
                                hasShotBall = true
                                autoGreen()
                            end
                        end
                    end)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input, gameProcessed)
                if gameProcessed then return end
            
                if input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.ButtonX then
                    holdingE = false
                end
            end)
        end
    })

    Main_Shooting:addToggle({
        text = "Autotime Feedback",
        default = false,
        callback = function(value)
            getgenv().AutotimeFeedback = value

            if value then
                hasShotBall = false
            end

            RunService.RenderStepped:Connect(function()
                if getgenv().AutotimeFeedback and getgenv().AutoGreen then
                    if hasShotBall and not feedBackShown then
                        hasShotBall = false
                        local lplr = game.Players.LocalPlayer
                        local ping = math.floor(game:GetService("Stats"):FindFirstChild("PerformanceStats"):FindFirstChild("Ping"):GetValue())
                        task.wait(0.5)
                        local releaseTiming = lplr.PlayerGui:FindFirstChild("Gameplay"):FindFirstChild("ShotFeedback"):FindFirstChild("Release").Text
                        Library:Notify("Ping: " .. ping .. "ms | " .. releaseTiming)
                    end
                end
            end)
        end
    })

    
    local currentCourt = "nothing selected"
    Main_Shooting:addToggle({
        text = "AutoShoot",
        default = false,
        risky = true,
        callback = function(value)
            getgenv().AutoShoot1 = value
            
            local function greenJumpshot()
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Shoot"):FireServer(true, 100)
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Shoot"):FireServer(false, -98, true)
            end

            local function getCourt()  
                local currentBasketball = nil            
                if game.PlaceId == PlaceIds.Park then
                    for _, court in ipairs(workspace:FindFirstChild("Courts"):GetChildren()) do
                        if court:IsA("Model") then
                            local valuesFolder = court:FindFirstChild("Values")
                            if valuesFolder then
                                local player1 = valuesFolder:FindFirstChild("Player1") and valuesFolder:FindFirstChild("Player1").Value
                                local player2 = valuesFolder:FindFirstChild("Player2") and valuesFolder:FindFirstChild("Player2").Value
                                local player3 = valuesFolder:FindFirstChild("Player3") and valuesFolder:FindFirstChild("Player3").Value
                                local player4 = valuesFolder:FindFirstChild("Player4") and valuesFolder:FindFirstChild("Player4").Value
    
                                if player1 == game.Players.LocalPlayer.Name or player2 == game.Players.LocalPlayer.Name or player3 == game.Players.LocalPlayer.Name or player4 == game.Players.LocalPlayer.Name then
                                    if court:GetPivot().Position == Vector3.new(-418.89190673828125, 20.46068000793457, 518.2275390625) then
                                        currentBasketball = court:FindFirstChild("Basketball")
                                        currentCourt = "1s Court1"
                                    elseif court:GetPivot().Position == Vector3.new(-170.8749237060547, 20.543899536132812, 512.031982421875) then
                                        currentBasketball = court:FindFirstChild("Basketball")
                                        currentCourt = "1s Court2"
                                    elseif court:GetPivot().Position == Vector3.new(-415.9677429199219, 20.626811981201172, 663.8275146484375) then 
                                        currentBasketball = court:FindFirstChild("Basketball")
                                        currentCourt = "2s Court1"
                                    elseif court:GetPivot().Position == Vector3.new(-170.51937866210938, 20.43025016784668, 649.9319458007812) then
                                        currentBasketball = court:FindFirstChild("Basketball")
                                        currentCourt = "2s Court2"
                                    end
                                end
                            end
                        end
                    end
                end
                return currentBasketball
            end

            local function Update()
                local basketball = getCourt()
                
                if basketball then
                    local hasBall = basketball:FindFirstChild("Player").Value
                    if getgenv().AutoShoot1 and hasBall == game.Players.LocalPlayer then
                        if currentCourt == '1s Court1' then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-408.82193, 3.85563254, 545.057434, 0.525831878, -6.750642e-08, 0.8505885, -3.4143067e-08, 1, 1.00471532e-07, -0.8505885, -8.18728338e-08, 0.525831878)
                            greenJumpshot()
                        elseif currentCourt == '1s Court2' then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-179.248306, 3.82514215, 489.723236, -0.511530876, -4.1698911e-08, -0.85926491, 1.30788598e-08, 1, -5.63145903e-08, 0.85926491, -4.00448563e-08, -0.511530876)
                            greenJumpshot()
                        elseif currentCourt == "2s Court1" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-414.042786, 3.81958199, 686.336121, 0.548263729, -5.98015459e-09, 0.836305499, -7.83298537e-10, 1, 7.6641955e-09, -0.836305499, -4.85707741e-09, 0.548263729)
                            greenJumpshot()
                        elseif currentCourt == '2s Court2' then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-173.601959, 3.87015486, 626.546021, -0.54294014, 3.42373951e-08, -0.83977139, -6.88517243e-09, 1, 4.52213946e-08, 0.83977139, 3.03344798e-08, -0.54294014)
                            greenJumpshot()
                        end
                    end
                end
            end
            
            RunService.RenderStepped:Connect(function()
                if getgenv().AutoShoot1 then
                    Update()
                end
            end)
        end
    })

    Main_Shooting:addLabel({text = "GOOD FOR BOOSTING"})
end

local Main_Player = Tabs.Main:createGroup('center', 'Player');
do
    Main_Player:addToggle({
        text = "Infinite Stamina",
        default = false,
        callback = function(value)
            getgenv().Stamina = value

            RunService.RenderStepped:Connect(function()
                if getgenv().Stamina then
                    if game:GetService("Players").LocalPlayer.Values.Stamina then
                        game:GetService("Players").LocalPlayer.Values.Stamina.Value = 1
                    end
                end
            end)
        end
    })
    local bringBallKeybind
    Main_Player:addToggle({
        text = "Bring Ball (BROKEN)",
        default = false,
        callback = function(value)
            getgenv().BallTP = value
            getgenv().BringBall = false
    
            local function getClosestBasketball()
                local closestBasketball = nil
                local closestDistance = math.huge
    
                if game.PlaceId == PlaceIds.Park or game.PlaceId == PlaceIds.Matchmaking then
                    for _, court in ipairs(workspace:FindFirstChild("Courts"):GetChildren()) do
                        if court:IsA("Model") then
                            local valuesFolder = court:FindFirstChild("Values")
                            if valuesFolder and valuesFolder:IsA("Folder") then
                                local player1 = valuesFolder:FindFirstChild("Player1") and valuesFolder:FindFirstChild("Player1").Value
                                local player2 = valuesFolder:FindFirstChild("Player2") and valuesFolder:FindFirstChild("Player2").Value
                                local player3 = valuesFolder:FindFirstChild("Player3") and valuesFolder:FindFirstChild("Player3").Value
                                local player4 = valuesFolder:FindFirstChild("Player4") and valuesFolder:FindFirstChild("Player4").Value
    
                                if player1 == game.Players.LocalPlayer.Name or player2 == game.Players.LocalPlayer.Name or player3 == game.Players.LocalPlayer.Name or player4 == game.Players.LocalPlayer.Name then
                                    for _, basketball in ipairs(court:GetChildren()) do
                                        if basketball.Name == "Basketball" and basketball:IsA("MeshPart") then
                                            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - basketball.Position).Magnitude
                                            if distance < closestDistance then
                                                closestBasketball = basketball
                                                closestDistance = distance
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                elseif game.PlaceId == PlaceIds.MyCourt then
                    for _, basketball in ipairs(workspace:FindFirstChild("Basketballs"):GetChildren()) do
                        if basketball.Name == "Basketball" and basketball:IsA("MeshPart") then
                            local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - basketball.Position).Magnitude
    
                            if distance < closestDistance then
                                closestBasketball = basketball
                                closestDistance = distance
                            end
                        end
                    end
                end
                return closestBasketball
            end
    
            local function grabBall()
                local basketball = getClosestBasketball()
    
                if basketball then
                    if basketball and (not basketball.Player or basketball.Player.Value == nil) then
                        basketball.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    end
                end
            end
    
            local inputBeganTP, inputEndedTP
    
            local function grabBallInputs()
                inputBeganTP = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
    
                    if input.KeyCode == bringBallKeybind or input.KeyCode == Enum.KeyCode.DPadUp then
                        getgenv().BringBall = true
                    end
                end)
    
                inputEndedTP = UserInputService.InputEnded:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
    
                    if input.KeyCode == bringBallKeybind or input.KeyCode == Enum.KeyCode.DPadUp then
                        getgenv().BringBall = false
                    end
                end)
            end
    
            game:GetService("RunService").RenderStepped:Connect(function()
                if getgenv().BallTP then
                    if getgenv().BringBall then
                        grabBall()
                    end
                else
                    if inputBeganTP then inputBeganTP:Disconnect() end
                    if inputEndedTP then inputEndedTP:Disconnect() end
                end
            end)
    
            grabBallInputs()
        end
    }):addKeybind({
        text = "Keybind",
        gui = false,
        type = "toggle",
        flag = "bringBallKeybind_",
        key = Enum.KeyCode.V,
        callback = function(state)
            bringBallKeybind = state
        end
    })

    Main_Player:addLabel({text = "CONTROLLER SUPPORT (Dpad Up)"})
end

local Menu_Settings = Tabs.Settings:createGroup('left', 'Menu');

do --// Menu
    Menu_Settings:addToggle({text = "Menu Bind",default = true,flag = "MenuBind"}):addKeybind({text = "Menu Bind",gui = false,type = "toggle",key = Enum.KeyCode.LeftControl,flag = "MenuKeybind",callback = function(state) Library.keybind = state end})
    Menu_Settings:addToggle({text = "Watermark",default = true,flag = "Watermark",callback = function(state) Library.Watermark:SetVisible(state) end})
    Menu_Settings:addToggle({text = "Keybinds",default = true,flag = "Keybinds",callback = function(state) Library:visualize(state) end})
    Menu_Settings:addButton({
        text = "Unload",
        callback = function()
            for i, v in ipairs(game:GetService("CoreGui"):GetChildren()) do
                if v.Name == "aura_gui" then
                    v:Destroy()
                end
                if v.Name == "Keybinds" then
                    v:Destroy()
                end
            end
        end
    })
end

--
local createConfigs = Tabs.Settings:createGroup('right', 'Configs')

do --// Configs
    createConfigs:addTextbox({text = "Name:",flag = "config_name"})
    createConfigs:addButton({text = "Create",callback = Library.createConfig})
    createConfigs:addConfigbox({flag = 'config_box',values = {}})
    createConfigs:addButton({text = "Load",callback = Library.loadConfig})
    createConfigs:addButton({text = "Overwrite",callback = Library.saveConfig})
    createConfigs:addButton({text = "Refresh",callback = function(refresh) Library:refreshConfigs(refresh) Library:Notify("Succesfully: refreshed all cfg's!", 5) end})
    createConfigs:addButton({text = "Delete",callback = Library.deleteConfig})
end 

local sound = Instance.new("Sound", game.CoreGui)
sound.SoundId = "rbxasset://awp/BlossomHubIntro3"
sound.PlayOnRemove = true

sound:Destroy()