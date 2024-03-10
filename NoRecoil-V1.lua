--[[
  _  _     ___            _ ___   ___         _           ___            
 | \| |___| _ \___ __ ___(_) \ \ / / |  ___  | |__ _  _  | __|_ __  __ _ 
 | .` / _ \   / -_) _/ _ \ | |\ V /| | |___| | '_ \ || | | _|| '  \/ _` |
 |_|\_\___/_|_\___\__\___/_|_| \_/ |_|       |_.__/\_, | |___|_|_|_\__,_|
                                                   |__/                  
--]]

-----------------------Customization - Leave it by default or edit by choice-----------------------

StartXValue = 0
StartYValue = 0
StartDelay = 0

OnOffScript = "NumLock" -- "CapsLock" "ScrollLock" "NumLock"
ShootButton = 1
AimButton = 3
MinDelay = 1 -- only affects when delay is on 0
MaxDelay = 10 -- only affects when delay is on 0

----------------------------------------Don't touch below------------------------------------------

function funcdelay(StartDelay)
    if StartDelay == 0 then
        StartDelay = math.random(MinDelay, MaxDelay)
    end
    return StartDelay
end

function base(StartYValue, StartXValue, StartDelay)
    ClearLog()
    OutputLogMessage([[
  _  _     ___            _ ___   ___         _           ___            
 | \| |___| _ \___ __ ___(_) \ \ / / |  ___  | |__ _  _  | __|_ __  __ _ 
 | .` / _ \   / -_) _/ _ \ | |\ V /| | |___| | '_ \ || | | _|| '  \/ _` |
 |_|\_\___/_|_\___\__\___/_|_| \_/ |_|       |_.__/\_, | |___|_|_|_\__,_|
                                                   |__/                  
CTRL + MOUSE BUTTON 5/4 to increase/decrease Y
SHIFT + MOUSE BUTTON 5/4 to increase/decrease X
ALT + MOUSE BUTTON 5/4 to increase/decrease Delay

Y = %d
X = %d
Delay = %d
]], StartYValue, StartXValue, StartDelay)
end

base(StartYValue, StartXValue, StartDelay)
EnablePrimaryMouseButtonEvents(true)
function OnEvent(event,arg)
    if IsKeyLockOn(OnOffScript) then
        if IsMouseButtonPressed(AimButton) then
            repeat
                if IsMouseButtonPressed(ShootButton) then
                    repeat
                        MoveMouseRelative(StartXValue, StartYValue)
                        Sleep(funcdelay(StartDelay))
                    until not IsMouseButtonPressed(ShootButton)
                end
            until not IsMouseButtonPressed(AimButton)
        end
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 5 and IsModifierPressed("ctrl") and not IsKeyLockOn("scrolllock") then
        StartYValue = StartYValue + 1
        base(StartYValue, StartXValue, StartDelay)
    end
    
    if event == "MOUSE_BUTTON_PRESSED" and arg == 4 and IsModifierPressed("ctrl") and not IsKeyLockOn("scrolllock") then
        StartYValue = StartYValue - 1
        base(StartYValue, StartXValue, StartDelay)
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 5 and IsModifierPressed("shift") and not IsKeyLockOn("scrolllock") then
        StartXValue = StartXValue + 1
        base(StartYValue, StartXValue, StartDelay)
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 4 and IsModifierPressed("shift") and not IsKeyLockOn("scrolllock") then
        StartXValue = StartXValue - 1
        base(StartYValue, StartXValue, StartDelay)
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 5 and IsModifierPressed("alt") and not IsKeyLockOn("scrolllock") then
        StartDelay = StartDelay + 1
        base(StartYValue, StartXValue, StartDelay)
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 4 and IsModifierPressed("alt") and not IsKeyLockOn("scrolllock") then
        StartDelay = StartDelay - 1
        base(StartYValue, StartXValue, StartDelay)
    end
end
