--print English name
--print(Game.localPlayer.charName)
--print Chinese name
print(Game.localPlayer.displayName)
local function Load()
    if Game.localPlayer.charName == "Nami" then
        Environment.LoadModule("Nami");

        return true;
    else
        return false;

    end
end
--Disable an existing champion


if Load() then

    Champions.CppScriptMaster(false);
else

    return

end

--Environment.LoadModule("Dev");


--UnLoad
Callback.Bind(CallbackType.OnUnload, function()
    Champions.Clean()--clean QWER Spell pointer , spell range dmobj
end)


--print("end");

