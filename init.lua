-- MX Master button remapping
-- Button 3 (back)        → previous desktop (ctrl+←)
-- Button 4 (forward)     → next desktop (ctrl+→)
-- Button 5 (thumb rest)  → Mission Control
--
-- Usage (as a Lua module):
--   _G.mxMouse = require("mx-mouse-fix")
-- The _G. prefix keeps the returned table alive so its hs.eventtap is
-- not garbage-collected after require returns.

local M = {}

local BACK_BUTTON = 3
local FORWARD_BUTTON = 4
local MISSION_CONTROL_BUTTON = 5

M.handler = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    local btn = e:getProperty(hs.eventtap.event.properties.mouseEventButtonNumber)

    if btn == BACK_BUTTON then
        local event = hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, true)
        event:post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.left, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.left, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, false):post()
        return true
    elseif btn == FORWARD_BUTTON then
        local event = hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, true)
        event:post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.right, true):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.right, false):post()
        hs.eventtap.event.newKeyEvent(hs.keycodes.map.ctrl, false):post()
        return true
    elseif btn == MISSION_CONTROL_BUTTON then
        hs.execute([[open -a "Mission Control"]])
        return true
    end

    return false
end)
M.handler:start()

if M.handler:isEnabled() then
    print("✓ Mouse button handler is running")
else
    print("✗ Mouse button handler FAILED to start")
end

return M
