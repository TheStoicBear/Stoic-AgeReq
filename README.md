# Stoic-AgeReq
![STOIC (1)](https://github.com/user-attachments/assets/1566f167-6d3b-4645-92b6-649c0a103de4)

Stoic-AgeReq is a FiveM resource designed to enforce age verification for players joining your server. It prompts players to confirm their age through an interactive dialog and takes action based on whether they meet the minimum age requirement set by your server.

## Features

- **Age Verification Dialog**: Displays a dialog using `lib.alertDialog` for players to enter their age.
- **Customizable Age Requirement**: Set a minimum age requirement in the configuration (`Config.lua`).
- **Flexible Action Handling**: Allows server administrators to configure actions such as kicking or banning underage players.
- **Integration with Discord Webhooks**: Sends status updates and player information to a specified Discord channel using webhooks.

## Why Use Stoic-AgeReq?

Stoic-AgeReq provides a free alternative to paid age verification resources available for FiveM servers. By using Stoic-AgeReq, server owners can ensure compliance with age restrictions without incurring additional costs.

## Installation

1. Download the latest release from the [releases page](https://github.com/YourGitHubUsername/Stoic-AgeReq/releases).
2. Extract the `Stoic-AgeReq` folder into your FiveM server's `resources` directory.
3. Add `ensure Stoic-AgeReq` to your `server.cfg` configuration file.
4. Configure `Config.lua` to set your desired minimum age requirement and action settings.

## Usage

Once installed and configured, Stoic-AgeReq will prompt players upon joining the server to verify their age. Actions specified in `Config.lua` will be taken automatically based on whether the player meets the age requirement.

## Configuration

Modify `Config.lua` to customize Stoic-AgeReq according to your server's specific requirements:

```lua
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

