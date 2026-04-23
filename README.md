# MX Mouse Fix

Remap Logitech MX Master back/forward buttons to switch macOS desktops using [Hammerspoon](https://www.hammerspoon.org/). A lightweight, reliable replacement for Logi Options+.

## What it does

| Button | Action |
|--------|--------|
| 3 — Back (below scroll wheel, rear) | Switch to left desktop (ctrl+←) |
| 4 — Forward (below scroll wheel, front) | Switch to right desktop (ctrl+→) |
| 5 — Thumb rest (large button under thumb) | Open Mission Control |

## Prerequisites

- macOS
- Logitech MX Master mouse (tested on MX Master 3S)
- Multiple desktops configured in Mission Control

## Installation

### 1. Uninstall Logi Options+ (if installed)

```bash
osascript -e 'quit app "logioptionsplus"' 2>/dev/null
pkill -f "logioptionsplus" 2>/dev/null

rm -rf "/Applications/logioptionsplus.app"
rm -f ~/Library/LaunchAgents/com.logi.optionsplus.plist
rm -f ~/Library/LaunchAgents/com.logitech.manager.daemon.plist
rm -rf ~/Library/Application\ Support/logioptionsplus
rm -rf ~/Library/Application\ Support/LogiOptionsPlus
rm -rf ~/Library/Caches/com.logi.optionsplus
rm -rf ~/Library/Preferences/com.logi.optionsplus.plist
rm -rf ~/Library/Logs/logioptionsplus

# May require sudo
sudo rm -f /Library/LaunchDaemons/com.logi.optionsplus.updater.plist
sudo rm -rf "/Library/Application Support/Logitech.localized"
sudo rm -rf "/Library/Application Support/Logitech"

# Verify removal
pgrep -fl logioptionsplus  # should return nothing
```

### 2. Install Hammerspoon

```bash
brew install --cask hammerspoon
open -a Hammerspoon
```

Grant **Accessibility** permissions when prompted:
**System Settings → Privacy & Security → Accessibility → toggle Hammerspoon on**

Enable launch at login:
**Hammerspoon menu bar icon → Preferences → Launch Hammerspoon at login**

### 3. Install the config

```bash
mkdir -p ~/.hammerspoon
cp init.lua ~/.hammerspoon/init.lua
```

Then reload: **Hammerspoon menu bar icon → Reload Config**

### 4. Verify Mission Control shortcuts

**System Settings → Keyboard → Keyboard Shortcuts → Mission Control**

Ensure these are enabled:
- Move left a space: `^←` (ctrl+left)
- Move right a space: `^→` (ctrl+right)

## Customization

The button numbers may differ depending on your specific mouse model. To find yours, paste this into the Hammerspoon console:

```lua
hs.eventtap.new({hs.eventtap.event.types.otherMouseDown}, function(e)
    local btn = e:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)
    hs.alert.show("Button: " .. btn)
    return false
end):start()
```

Click your buttons and note the numbers, then update `BACK_BUTTON`, `FORWARD_BUTTON`, and `MISSION_CONTROL_BUTTON` in `init.lua`.

## Copy to another Mac

```bash
scp init.lua <user>@<other-mac>:~/.hammerspoon/init.lua
```

Then install Hammerspoon on the other Mac, grant Accessibility permissions, and reload config.

## Why not Logi Options+?

- Hammerspoon is open-source, lightweight, and has no telemetry
- Logi Options+ frequently loses settings after updates
- No background updater or cloud sync eating resources
- Plain Lua config file you control — not a proprietary database
- Survives macOS updates better (Accessibility app vs. kernel extension)

## Related

- [warp-claude-hotkey](https://github.com/timomak/warp-claude-hotkey) — sibling Hammerspoon config: Cmd+Shift+D splits the current Warp pane and launches Claude Code in it.

The two configs are independent and can be combined in a single `~/.hammerspoon/init.lua` — no conflicts.

## License

MIT
