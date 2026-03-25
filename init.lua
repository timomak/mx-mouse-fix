-- MX Master: remap back/forward buttons to switch desktops
-- Button 4 (back) → previous desktop
-- Button 3 (forward) → next desktop

local BACK_BUTTON = 3
local FORWARD_BUTTON = 4

local mouseHandler = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
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
    end

    return false
end)

mouseHandler:start()

if mouseHandler:isEnabled() then
    print("✓ Mouse button handler is running")
else
    print("✗ Mouse button handler FAILED to start")
end
