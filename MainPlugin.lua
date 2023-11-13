local lplr = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")

function RobloxNotification(first, second, time)
    game.StarterGui:SetCore("SendNotification", {
        Title = first,
        Text = second,
        Duration = time
    })
end

function generateString()
    local chars = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "X", "Z"}
    local str = ""

    for i = 1, 36 do
        if i == 5 or i == 10 or i == 15 or i == 20 then
            str = str .. "-"
        else
            str = str .. chars[math.random(2, #chars)]
        end
    end
    return str
end

-- Function to generate a random letter
function getRandomLetter()
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local randomIndex1 = math.random(1, #alphabet)
    local randomIndex2 = math.random(1, #alphabet)
    
    local letter1 = alphabet:sub(randomIndex1, randomIndex1)
    local letter2 = alphabet:sub(randomIndex2, randomIndex2)

    return letter1, letter2
end

function executor()
    local strings = {"Project Ligma", "Synape x", "Project Stigma", "Project Potato", "Fluxus", "Hydrogen", "Delta", "Codex", "Nil executor", "Unknown", "Evon", "Celery", "Electron", "Arceus x", "Comet", "Oxygen U", "Krnl", "Furk Ultra", "Trigon Evo", "Valyse", "Atonix", "RC7", "JJsploit", "ProtonSmasher"}
    return strings[math.random(1, #strings)]
end

local spoof = {}

delta.Settings:AddSwitch("Anti Client Kick", "Only works if it localscript", false, function(state)
    if state then
    local oldhmmi
    local oldhmmnc
    oldhmmi = hookmetamethod(game, "__index", function(self, method)
        if self == lplr and method:lower() == "kick" then
            return error("Expected ':' not '.' calling member function kick", 2)
        end
        return oldhmmi(self, method)
    end)
    oldhmmnc = hookmetamethod(game, "__namecall", function(self, ...)
        if self == lplr and getnamecallmethod():lower() == "kick" then
            return
        end
        return oldhmmnc(self, ...)
    end)
    RobloxNotification("Enabled", "keep in mind that this only effective if the game uses Localscript to kick", 3)
else
    RobloxNotification("Disbaled", "Client Anti Kick has been disabled!", 3)
end
end)

delta.Settings:AddButton("Spoof IP", "Your real ip will change to fake one (like vpn)", function()
    spoof.Http = function(a) return game:HttpGet(a) end
    spoof.IP = game:HttpGet('https://api.ipify.org/')

    number = tostring(math.random(99999999))
    ip = tostring(math.random(255).."."..math.random(255).."."..math.random(255).."."..math.random(255))

    RobloxNotification("IP Address", "Your fake IP Address: ".. ip, 3)
    print(ip)

    wait(1)

    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)

delta.Settings:AddButton("Spoof Client ID (Hardware ID)", "this feature will change your hardware id to randdom one", function()
    cid_spoof = generateString()

    local OldIndex

    OldIndex = hookmetamethod(game, "__namecall", function(...)
        if getnamecallmethod() == "GetClientId" then
            return cid_spoof
        end

        return OldIndex(...)
    end)

    RobloxNotification("Hardware ID", "Your spoofed hardware id: ".. cid_spoof, 3)
    print(cid_spoof)

    wait(1)
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)

delta.Settings:AddButton("Spoof Username, UserId, DisplayName", "Changes your username to random", function()
    namrk = game:HttpGet('https://api.namefake.com')
    namrk = HttpService:JSONDecode(namrk)
    name = namrk.name
    rename = string.lower(name)

    lplr.Name = rename
    lplr.DisplayName = rename
    lplr.UserId = number

    RobloxNotification("Username", "Your fake username:".. lplr.Name, 3)
    RobloxNotification("DisplayName", "Your fake DisplayName: ".. lplr.UserId, 3)
    RobloxNotification("User ID", "Your fake User ID: ".. lplr.UserId, 3)

    wait(1)
    print(lplr.Name)
    print(lplr.DisplayName)
    print(lplr.UserId)
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)

delta.Settings:AddButton("Spoof Executor", "this feature will change your executor name to random executor", function()
    executor_spoof = executor()

    da = hookfunction
    
    if identifyexecutor then
        da(identifyexecutor, newcclosure(function() return executor_spoof end))
    end

    RobloxNotification("Executor", "Your fake exexcutor: ".. executor_spoof, 3)

    wait(1)
    print(identifyexecutor())
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
end)
