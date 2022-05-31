

DevMenu = UI.Menu.CreateMenu("dev", "Dev", 1);
Champions.CreateBaseMenu(DevMenu, 0);

KeyPrint=nil;


He = Game.localPlayer;
local function LoadMenu()


   local Properties= DevMenu:AddMenu("Properties", "Properties");
    KeyPrint= Properties:AddKeyBind("keyPrint", ("Key Print"), 84, false, false);


end

LoadMenu();

local function ontick()


    if KeyPrint.value then

     --print(   He:IsPlayingAnimation(Game.fnvhash("Spell4_idle")))

        local buffNames="";
        --
        print(He.charName .."--------buff-----")
        for i, v in He.buffManager.buffs:pairs() do
            if v.isValid  then
                buffNames=buffNames..'=='..v:GetName()

            end
        end
        print(buffNames)
        print("-------buff end------")
        --
        --print(He.canMove);
        --
        --print(He.isCasting)
    end

end

Callback.Bind(CallbackType.OnTick, ontick)

local function OnPlayAnimation(sender,animationName)

    --print(animationName)
end
Callback.Bind(CallbackType.OnPlayAnimation, OnPlayAnimation)

