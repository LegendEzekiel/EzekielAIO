

DevMenu = UI.Menu.CreateMenu("dev", "Dev", 1);
Champions.CreateBaseMenu(DevMenu, 0);

KeyPrint=nil;


He = Game.localPlayer;
local function LoadMenu()


   local Properties= DevMenu:AddMenu("Properties", "Properties");
    KeyPrint= Properties:AddKeyBind("keyPrint", ("Key Print"), 84, false, false);


end

LoadMenu();
EnemyCastSpellCantMoveList = {
    ['Janna'] = {
        ['ReapTheWhirlwind'] = {
            ['value'] = true,
            ['Cast'] = 0,
            ['Alias'] = "R"
        }
    },
    ['Nunu'] = {
        ['nunurshield'] = {
            ['value'] = true,
            ['Cast'] = 2,
            ['Alias'] = "R"
        }
    },

    ['Velkoz'] = {
        ['VelkozR'] = {
            ['value'] = true,
            ['Cast'] = 2,
            ['Alias'] = "R"
        }
    },
    ['Xerath'] = {
        ['xerathrshors'] = {
            ['value'] = true,
            ['Cast'] = 2,
            ['Alias'] = "R"
        }
    },
    ['Katarina'] = {
        ['katarinarsound'] = {
            ['value'] = true,
            ['Cast'] = 2,
            ['Alias'] = "R"
        }
    },

    ['Malzahar'] = {
        ['malzaharrsound'] = {
            ['value'] = true,
            ['Cast'] = 0,
            ['Alias'] = "R"
        }
    }
}
AnimSpell = {
    ['Jhin'] = {--R Anim
        ['Spell4_idle'] = {
            ['value'] = true,
            ['Cast'] = 0,
            ['Alias'] = "R Start"
        },
        ['Spell4'] = {
            ['value'] = true,
            ['Cast'] = 0,
            ['Alias'] = "R Continued"
        }
    },
    ['Nunu'] = {
        ['Spell4'] = {
            ['value'] = true,
            ['Cast'] = 2,
            ['Alias'] = "R"
        }
    },
    ['Katarina'] = {
        ['Spell4'] = {
            ['value'] = true,
            ['Cast'] = 2,
            ['Alias'] = "R"
        }
    },
    ['Janna'] = {
        ['Spell4'] = {
            ['value'] = true,
            ['Cast'] = 0,
            ['Alias'] = "R"
        }
    },
    ['Malzahar'] = {
        ['Spell4'] = {
            ['value'] = true,
            ['Cast'] = 0,
            ['Alias'] = "R"
        }
    },
    ['Velkoz'] = {
        ['Spell4'] = {
            ['value'] = true,
            ['Cast'] = 2,
            ['Alias'] = "R"
        }
    }

}
local function GetBuffByName(t, buffName)
    for i, v in t.buffManager.buffs:pairs() do
        if v.isValid  and  v:GetName() ==buffName then

            return true
        end
    end
end

local function UseQBySpellCantMove()

    for _, enemy in ObjectManager.allyHeroes:pairs() do

        if enemy:IsValidTarget(875) then
            --Not Nil
            if AnimSpell[enemy.charName] then
                if enemy.isAlive then
                    for index, data in     pairs(AnimSpell[enemy.charName]) do
                        if   He:IsPlayingAnimation(Game.fnvhash(index)) then
                            Q:Cast(enemy.position);
                            print("找到了");
                        end

                    end
                end
            end
        end
    end


end



local function ontick()

    if Champions.Combo then


        UseQBySpellCantMove();
    end


    if KeyPrint.value then

     print(   He:IsPlayingAnimation(Game.fnvhash("Spell4")))

        --local buffNames="";
        ----
        --print(He.charName .."--------buff-----")
        --for i, v in He.buffManager.buffs:pairs() do
        --    if v.isValid  then
        --        buffNames=buffNames..'=='..v:GetName()
        --
        --    end
        --end
        --print(buffNames)
        --print("-------buff end------")
        --
        --print(He.canMove);
        --
        --print(He.isCasting)




    end

end

Callback.Bind(CallbackType.OnTick, ontick)

local function OnPlayAnimation(sender,animationName)

    print(animationName)
end
Callback.Bind(CallbackType.OnPlayAnimation, OnPlayAnimation)

