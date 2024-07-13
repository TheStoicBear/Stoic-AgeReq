local function calculateAge(timestamp)
    print("Received Date of Birth (timestamp): " .. timestamp)  -- Print the received timestamp for debugging

    local birthDate = os.date("*t", tonumber(timestamp) / 1000) -- Convert from milliseconds to seconds
    if not birthDate then
        return nil, "Invalid date"
    end

    print("BirthDate: " .. json.encode(birthDate)) -- Print birthDate for debugging

    local currentDate = os.date("*t")
    print("CurrentDate: " .. json.encode(currentDate)) -- Print currentDate for debugging

    local age = currentDate.year - birthDate.year
    if currentDate.month < birthDate.month or (currentDate.month == birthDate.month and currentDate.day < birthDate.day) then
        age = age - 1
    end

    return age
end

RegisterServerEvent('stoic:verifyAge')
AddEventHandler('stoic:verifyAge', function(timestamp)
    local player = source
    local steamID = nil
    local discordID = nil

    for i = 0, GetNumPlayerIdentifiers(player) - 1 do
        local id = GetPlayerIdentifier(player, i)
        if string.match(id, "steam:") then
            steamID = id
        elseif string.match(id, "discord:") then
            discordID = id
        end
    end

    if not discordID then
        print("Player does not have a linked Discord ID.")
        return
    end

    local age, err = calculateAge(timestamp)
    if not age then
        print("Error calculating age: " .. err)
        return
    end

    local approved = age >= Config.MinimumAge
    TriggerClientEvent('stoic:ageVerificationResult', player, steamID, discordID, age, approved)
    if approved then
        -- Player is above or equal to the minimum age
        -- Add your custom logic for players who meet the age requirement here
        print("Player meets the age requirement.")
    else
        -- Player is underage
        -- Add your custom logic for underage players here
        print("Player is underage.")
        
        -- Example: Kick the player if configured to do so
        if Config.KickUnderage then
            DropPlayer(player, "You are under the minimum age required to play on this server.")
        end
        
        -- Example: Ban the player if configured to do so
        -- Assuming you have a ban system in place
        if Config.BanUnderage then
            --MyBanSystem.BanPlayer(player, "Underage - Banned for violating age requirement")
        end
    end
    
    local color = approved and 65280 or 16776960
    local embed = {
        {
            ["title"] = "Age Verification",
            ["description"] = "A player has verified their age.",
            ["fields"] = {
                {
                    ["name"] = "SteamID",
                    ["value"] = steamID,
                    ["inline"] = true
                },
                {
                    ["name"] = "DiscordID",
                    ["value"] = discordID,
                    ["inline"] = true
                },
                {
                    ["name"] = "Age",
                    ["value"] = tostring(age),
                    ["inline"] = true
                }
            },
            ["color"] = color
        }
    }

    PerformHttpRequest(Config.WebhookURL, function(err, text, headers) end, 'POST', json.encode({username = "Age Verification Bot", embeds = embed}), { ['Content-Type'] = 'application/json' })
end)
