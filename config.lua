Config = {}

-- Discord Webhook URL
Config.WebhookURL = 'YOUR_WEBHOOK_URL'
Config.KickUnderage = true
Config.BanUnderage = true
Config.MinimumAge = 18

Config.Dialog = {
    header = "Age Verification",
    content = {
        {
            type = 'date',
            label = 'Please enter your date of birth',
            required = true,
            min = '01/01/1900',-- 124 Years old
            max = '12/31/2004' --18 Years old.
        }
    },
    allowCancel = true
}
