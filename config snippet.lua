------------------------------------------------------------------------------------------
-- Microphone Push-To-Talk
-- timginter @ GitHub
------------------------------------------------------------------------------------------

local pushToTalk = true
local suppressFnKey = false
local suppressMouseForward = true

------------------------------------------------------------------------------------------

local muteKeyPressed = false

-- create tray icon/text
local menuBarIcon = hs.menubar.new(true)

function muteAllInputDevices()
    local inputDevices = hs.audiodevice.allInputDevices()
    for key, inputDevice in pairs(inputDevices) do
        inputDevice:setMuted(true)
    end
    menuBarIcon:setTitle("Mic OFF")
end

function unmuteAllInputDevices()
    local inputDevices = hs.audiodevice.allInputDevices()
    for key, inputDevice in pairs(inputDevices) do
        inputDevice:setMuted(false)
    end
    menuBarIcon:setTitle("Mic ON")
end

function toggleInputDevicesMute()
    local inputDevices = hs.audiodevice.allInputDevices()
    if inputDevices == nil then
        return
    end

    if inputDevices[1]:muted() then
        unmuteAllInputDevices()
    else
        muteAllInputDevices()
    end
end

-- capture mouse button "Forward"
overrideMouseForwardDown = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    -- mouse button "Forward"
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) == 4 then
        -- unmute only if pushToTalk is enabled
        if pushToTalk then
            unmuteAllInputDevices()
        end

        -- update key pressed status
        muteKeyPressed = true

        return suppressMouseForward
    end
end)
overrideMouseForwardUp = hs.eventtap.new({ hs.eventtap.event.types.otherMouseUp }, function(e)
    -- mouse button "Forward"
    if e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber']) == 4 then
        if pushToTalk then
            muteAllInputDevices()
        else
            toggleInputDevicesMute()
        end

        -- update key pressed status
        muteKeyPressed = false

        return suppressMouseForward
    end
end)

-- capture Fn key
overrideFn = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
    -- only Fn key Down or Up
    if e:getType() == 12 and e:getKeyCode() == 63 then
        -- toggle mute only if pushToTalk enabled or mute key is not already down
        if pushToTalk or not muteKeyPressed then
            toggleInputDevicesMute()
        end

        -- update key pressed status
        muteKeyPressed = not muteKeyPressed

        return suppressFnKey
    end
end)

-- mute all input devices on init
muteAllInputDevices()
-- start override functions
overrideMouseForwardDown:start()
overrideMouseForwardUp:start()
overrideFn:start()

------------------------------------------------------------------------------------------
-- END OF Microphone Push-To-Talk
------------------------------------------------------------------------------------------
