--[[
  _  _     ___            _ ___   _____   _         _           ___            
 | \| |___| _ \___ __ ___(_) \ \ / /_  ) / |  ___  | |__ _  _  | __|_ __  __ _ 
 | .` / _ \   / -_) _/ _ \ | |\ V / / / _| | |___| | '_ \ || | | _|| '  \/ _` |
 |_|\_\___/_|_\___\__\___/_|_| \_/ /___(_)_|       |_.__/\_, | |___|_|_|_\__,_|
                                                         |__/                  
--]]

-----------------------Customization - Leave it by default or edit by choice-----------------------

indiceCorrente = 1

OnOffScript = "NumLock" -- "CapsLock" "ScrollLock" "NumLock"
OnOffRapidfire = "NumLock"
ShootButton = 1
AimButton = 3
RapidfireButton = 5
MinDelay = 1 -- only affects when delay is on 0
MaxDelay = 10

----------------------------Presets - If Delay is 0 turn on random delay---------------------------

valori = {
    {nome = "TUBARAO", XStrenght = 0, YStrenght = 10, Delay = 0},
    {nome = "RAM", XStrenght = -1, YStrenght = 15, Delay = 0},
    {nome = "EMPTY", XStrenght = 0, YStrenght = 0, Delay = 0},
}

----------------------------------------Don't touch below------------------------------------------

function funcdelay(Delay)
  if Delay == 0 then
    Delay = math.random(MinDelay, MaxDelay)
  end
  return Delay
end

function base(nome, XStrenght, YStrenght, Delay)
    ClearLog()
    OutputLogMessage([[
  _  _     ___            _ ___   _____   _         _           ___            
 | \| |___| _ \___ __ ___(_) \ \ / /_  ) / |  ___  | |__ _  _  | __|_ __  __ _ 
 | .` / _ \   / -_) _/ _ \ | |\ V / / / _| | |___| | '_ \ || | | _|| '  \/ _` |
 |_|\_\___/_|_\___\__\___/_|_| \_/ /___(_)_|       |_.__/\_, | |___|_|_|_\__,_|
                                                         |__/                  
NUMLOCK to toggle the script
CTRL + MOUSE WHEEL to scroll presets
RIGHT MOUSE BUTTON + MOUSE BUTTON 5 to turn on rapidfire

%s: X = %d | Y = %d | Delay = %d
]], valori[indiceCorrente].nome, valori[indiceCorrente].XStrenght, valori[indiceCorrente].YStrenght, valori[indiceCorrente].Delay)
end

base(valori[indiceCorrente].nome, valori[indiceCorrente].XStrenght, valori[indiceCorrente].YStrenght, valori[indiceCorrente].Delay)
EnablePrimaryMouseButtonEvents(true)

function OnEvent(event, arg)
    if IsKeyLockOn(OnOffScript) then
        if IsMouseButtonPressed(AimButton) then
            while IsMouseButtonPressed(AimButton) do
                if IsMouseButtonPressed(ShootButton) then
                    MoveMouseRelative(valori[indiceCorrente].XStrenght, valori[indiceCorrente].YStrenght)
                    Sleep(funcdelay(valori[indiceCorrente].Delay))
                elseif IsKeyLockOn(OnOffRapidfire) then
                    if IsMouseButtonPressed(RapidfireButton) then
                      repeat
                        PressAndReleaseMouseButton(ShootButton)
                        Sleep(10)
                      until not IsMouseButtonPressed(RapidfireButton)
                    end
                end
            end
        end
        
    end

    if event == "MOUSE_BUTTON_PRESSED" and arg == 3 and IsModifierPressed("lctrl") then
        indiceCorrente = (indiceCorrente % #valori) + 1
        base(valori[indiceCorrente].nome, valori[indiceCorrente].XStrenght, valori[indiceCorrente].YStrenght, valori[indiceCorrente].Delay)
    end
end
