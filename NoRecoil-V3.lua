--[[
  _  _     ___            _ ___   ______        _           ___            
 | \| |___| _ \___ __ ___(_) \ \ / /__ /  ___  | |__ _  _  | __|_ __  __ _ 
 | .` / _ \   / -_) _/ _ \ | |\ V / |_ \ |___| | '_ \ || | | _|| '  \/ _` |
 |_|\_\___/_|_\___\__\___/_|_| \_/ |___/       |_.__/\_, | |___|_|_|_\__,_|
                                                     |__/                  
--]]

-----------------------Customization - Leave it by default or edit by choice-----------------------
-- ┌────────────────────────────────────────┐
-- │ CTRL + S TO SAVE AFTER EDITING / START │
-- └────────────────────────────────────────┘

indiceCorrente = 1 -- active preset on startup

OnOffScript = "CapsLock" -- "CapsLock" "ScrollLock" "NumLock"
OnOffRecoil = "CapsLock"
OnOffRapidfire = "CapsLock"

ComboKey = "ctrl" -- "ctrl" "lctrl" "rctrl" "shift" "lshift" "rshift" "alt" "lalt" "ralt"
NextPreset = 5 -- 1 = LEFT BUTTON, 2 = RIGHT BUTTON, 3 = MOUSE WHEEL or RIGHT BUTTON (depends), 4 = LATERAL BACK BUTTON, 5 = LATERAL FRONT BUTTON, ecc...
PreviousPreset = 4
ShootButton = 1
AimButton = 3
RapidfireButton = 5

RapidfireDelay = 50 -- no randomization on this for now, coming soon
MinDelay = 1 -- only affects when delay is on 0 in preset
MaxDelay = 10 -- only affects when delay is on 0 in preset

---------------Presets - Feel free to add some - If Delay is 0 turn on random delay----------------

valori = {
    {nome = "PRESET 1", XStrenght = 0, YStrenght = 10, Delay = 0},
    {nome = "PRESET 2", XStrenght = -1, YStrenght = 15, Delay = 50},
    {nome = "PRESET 3", XStrenght = 0, YStrenght = 0, Delay = 0}
}

---------------------------------Don't touch below without knowing---------------------------------

function funcdelay(Delay)
    if Delay == 0 then
        Delay = math.random(MinDelay, MaxDelay)
    end
    return Delay
end

function base()
    ClearLog()
    OutputLogMessage(
        [[
  _  _     ___            _ ___   ______        _           ___            
 | \| |___| _ \___ __ ___(_) \ \ / /__ /  ___  | |__ _  _  | __|_ __  __ _ 
 | .` / _ \   / -_) _/ _ \ | |\ V / |_ \ |___| | '_ \ || | | _|| '  \/ _` |
 |_|\_\___/_|_\___\__\___/_|_| \_/ |___/       |_.__/\_, | |___|_|_|_\__,_|
                                                     |__/                  
┌─────────────────────────────────────────┐
│ https://github.com/EmaBixD/LUA-NoRecoil │
├─────────────────────────────────────────┘
│ %s to toggle the script
│ %s to toggle the no-recoil script
│ %s to toggle the rapidfire script
│ %s + MOUSE BUTTON %d to the next preset
│ %s + MOUSE BUTTON %d to the previous preset
└ MOUSE BUTTON %s + MOUSE BUTTON %d for rapidfire

Active preset:
%s: X = %d | Y = %d | Delay = %d
]],
        OnOffScript,
        OnOffRecoil,
        OnOffRapidfire,
        ComboKey,
        NextPreset,
        ComboKey,
        PreviousPreset,
        AimButton,
        RapidfireButton,
        valori[indiceCorrente].nome,
        valori[indiceCorrente].XStrenght,
        valori[indiceCorrente].YStrenght,
        valori[indiceCorrente].Delay
    )
end

base()
EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    if IsKeyLockOn(OnOffScript) then
        if IsMouseButtonPressed(AimButton) then
            while IsMouseButtonPressed(AimButton) do
                if IsKeyLockOn(OnOffRecoil) then
                    if IsMouseButtonPressed(ShootButton) then
                        MoveMouseRelative(valori[indiceCorrente].XStrenght, valori[indiceCorrente].YStrenght)
                        Sleep(funcdelay(valori[indiceCorrente].Delay))
                    end
                end
                if IsKeyLockOn(OnOffRapidfire) then
                    if IsMouseButtonPressed(RapidfireButton) then
                        repeat
                            PressAndReleaseMouseButton(ShootButton)
                            Sleep(RapidfireDelay)
                        until not IsMouseButtonPressed(RapidfireButton)
                    end
                end
            end
        end
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == NextPreset and IsModifierPressed(ComboKey) then
        indiceCorrente = (indiceCorrente % #valori) + 1
        base()
    end
    if event == "MOUSE_BUTTON_PRESSED" and arg == PreviousPreset and IsModifierPressed(ComboKey) then
      indiceCorrente = ((indiceCorrente - 2) % #valori) + 1
      base()
    end
end
