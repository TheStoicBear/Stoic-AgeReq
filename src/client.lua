RegisterCommand('verifyage', function()
    local result = lib.inputDialog(Config.Dialog.header, Config.Dialog.content, {
        { type = "date", label = "Date of Birth", required = true, format = "DD/MM/YYYY" }
    }, { allowCancel = Config.Dialog.allowCancel })

    if result then
        local dob = result[1]
        if dob then
            print("Date of Birth entered: " .. dob)
            -- Send the date of birth to the server for verification
            TriggerServerEvent('stoic:verifyAge', dob)
        else
            print('Invalid date of birth entered.')
        end
    else
        print('Age verification cancelled or closed.')
    end
end, false)

RegisterNetEvent('stoic:ageVerificationResult')
AddEventHandler('stoic:ageVerificationResult', function(steamID, discordID, age, approved)
    print("Age verification result received.")
end)
