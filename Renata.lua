SpellData = {
    ["Q"] = {
        ['range'] = 900,
        ['delay'] = 0.25,
        ['width'] = 140,
        ['speed'] = 1450,
        ['type'] = SkillshotType.SkillshotLine,
        ['collision'] = true,
        ['collisionFlags'] = bit.bor(CollisionFlag.CollidesWithYasuoWall, CollisionFlag.CollidesWithMinions, CollisionFlag.CollidesWithHeroes),
        ['minHitChance'] = HitChance.High,
        ['boundingRadiusMod'] = false
    },
    ["E"] = {
        ['range'] = 800,
        ['delay'] = 0.25,
        ['width'] = 220,
        ['speed'] = 1450,
        ['type'] = SkillshotType.SkillshotLine,
        ['collision'] = true,
        ['collisionFlags'] = CollisionFlag.CollidesWithYasuoWall,
        ['minHitChance'] = HitChance.High,
        ['boundingRadiusMod'] = false
    },

    ["R"] = {
        ['maxRange'] = 2000,
        ['range'] = 2000,
        ['delay'] = 0.75,
        ['width'] = 500,
        ['speed'] = 650,
        ['type'] = SkillshotType.SkillshotLine,
        ['collision'] = true,
        ['collisionFlags'] = CollisionFlag.CollidesWithYasuoWall,
        ['minHitChance'] = HitChance.High,
        ['boundingRadiusMod'] = true
    },

}

My = Game.localPlayer;
Menu = UI.Menu.CreateMenu(My.charName, Game.localPlayer.displayName, 2);
Champions.CreateBaseMenu(Menu, 0);
Q = nil;
W = nil;
E = nil;
R = nil;
MenuConfig = {
    ["Combo"] = {
        ['Use Q'] = nil;
        ['Use Q2'] = nil;
        ['Use Q Objcet'] = {};
        ['Use Q2 Objcet'] = {};
        ['Use Q Mode'] = {};
        ['Use W'] = nil;
        ['Use W Objcet'] = {};
        ['Use W Level'] = {};

        ['Use E'] = nil;
        ['Use R'] = nil;
        ['Use Key R'] = nil;
        ['Use R Number'] = nil;
    },
    ["Harass"] = {
        ['Use Q'] = nil;
        ['Use E'] = nil;
    },
    ["Auto"] = {
        ['Auto W'] = nil;
        ['Use W Objcet'] = {};
        ['Use W Perd'] = {};
        ['Use W HP'] = {};

    },
    ['Use Range'] = {
        ['Q'] = nil;
        ['W'] = nil;
        ['E'] = nil;
        ['R'] = nil;

    },
    ['Draw'] = {

    }


};

local function Init()


    Champions.Q = (SDKSpell.Create(SpellSlot.Q, MenuConfig['Use Range']['Q'].value, DamageType.Magical))
    Champions.W = (SDKSpell.Create(SpellSlot.W, MenuConfig['Use Range']['W'].value, DamageType.Magical))
    Champions.E = (SDKSpell.Create(SpellSlot.E, MenuConfig['Use Range']['E'].value, DamageType.Magical))
    Champions.R = (SDKSpell.Create(SpellSlot.R, MenuConfig['Use Range']['R'].value, DamageType.Magical))

    Champions.Q:SetSkillshot(
            SpellData['Q']['delay'],
            SpellData['Q']['width'],
            SpellData['Q']['speed'],
            SpellData['Q']['type'],
            SpellData['Q']['collision'],
            SpellData['Q']['collisionFlags'],
            SpellData['Q']['minHitChance'],
            SpellData['Q']['boundingRadiusMod']
    );

    Champions.E:SetSkillshot(
            SpellData['E']['delay'],
            SpellData['E']['width'],
            SpellData['E']['speed'],
            SpellData['E']['type'],
            SpellData['E']['collision'],
            SpellData['E']['collisionFlags'],
            SpellData['E']['minHitChance'],
            SpellData['E']['boundingRadiusMod']
    );

    Champions.R:SetSkillshot(
            SpellData['R']['delay'],
            SpellData['R']['width'],
            SpellData['R']['speed'],
            SpellData['R']['type'],
            SpellData['R']['collision'],
            SpellData['R']['collisionFlags'],
            SpellData['R']['minHitChance'],
            SpellData['R']['boundingRadiusMod']
    );

    Q = Champions.Q;
    W = Champions.W;
    E = Champions.E;
    R = Champions.R;
end

local function LoadMenu()


    local Combo = Menu:AddMenu("Combo", "Combo");
    MenuConfig['Combo']['Use Q'] = Combo:AddCheckBox("useQ", 'Use Q');

    local WhitelistQ = Combo:AddMenu("QSettings", "Q Settings");
    for _, enemy in ObjectManager.enemyHeroes:pairs() do
        local qCharMenu = WhitelistQ:AddMenu(enemy.charName .. "Menu", enemy.charName);

        MenuConfig['Combo']['Use Q Objcet'][enemy.charName] = qCharMenu:AddCheckBox('use', "Use Q1");
        MenuConfig['Combo']['Use Q2 Objcet'][enemy.charName] = qCharMenu:AddCheckBox('use2', "Use Q2");
        if enemy.isMelee then
            MenuConfig['Combo']['Use Q Mode'][enemy.charName] = qCharMenu:AddList("model", "Q Model", { "Olny Pull(Turret)", "Push(Turret) Or Push To Enemy", "Pull(Turret) Or Push To Enemy" }, 1);
        else
            MenuConfig['Combo']['Use Q Mode'][enemy.charName] = qCharMenu:AddList("model", "Q Model", { "Olny Pull(Turret)", "Push(Turret) Or Push To Enemy", "Pull(Turret) Or Push To Enemy" }, 2);
        end

    end
    MenuConfig['Combo']['Use Q2'] = Combo:AddCheckBox("useQ2", 'Use Q2');

    MenuConfig['Combo']['Use W'] = Combo:AddCheckBox("useW", 'Use W');
    local Wmenu = Combo:AddMenu("Wsetting", "W Settings");
    for _, ally in ObjectManager.allyHeroes:pairs() do
        local charMenu = Wmenu:AddMenu(ally.charName .. "Menu", ally.charName);
        MenuConfig['Combo']['Use W Objcet'][ally.charName] = charMenu:AddCheckBox(ally.charName .. "Use", "Use");
        MenuConfig['Combo']['Use W Objcet'][ally.charName]:AddTooltip("In combo mode,Use after automatic attack");

        MenuConfig['Combo']['Use W Level'][ally.charName] = charMenu:AddSlider(ally.charName .. "Level", "Priority Level", 1, 1, 5);


    end

    MenuConfig['Combo']['Use E'] = Combo:AddCheckBox("useE", 'Use E');

    MenuConfig['Combo']['Use R'] = Combo:AddCheckBox("useR", 'Use R');
    MenuConfig['Combo']['Use Key R'] = Combo:AddKeyBind("keyR", ("Key R"), 84, false, false);
    MenuConfig['Combo']['Use Key R']:PermaShow(true, true);
    MenuConfig['Combo']['Use R Number'] = Combo:AddSlider("useRrange", 'Use R >= X Enemy', 3, 1, 5)

    MenuConfig['Combo']['Use R Number']:PermaShow(true, true);

    local Harass = Menu:AddMenu("Harass", "Harass");
    MenuConfig['Harass']['Use Q'] = Harass:AddCheckBox("useQ", 'Use Q')
    MenuConfig['Harass']['Use E'] = Harass:AddCheckBox("useE", 'Use E');

    local Auto = Menu:AddMenu("Auto", "Auto");
    MenuConfig['Auto']['Auto W'] = Auto:AddCheckBox("autoW", 'Auto W');

    local autoWsettings = Auto:AddMenu("Wsetting", "W Settings");

    for _, ally in ObjectManager.allyHeroes:pairs() do
        local autoCharMenu = autoWsettings:AddMenu(ally.charName .. "Menu", ally.charName);

        MenuConfig['Auto']['Use W Objcet'][ally.charName] = autoCharMenu:AddCheckBox(ally.charName .. "Use", "Use");

        MenuConfig['Auto']['Use W HP'][ally.charName] = autoCharMenu:AddSlider(ally.charName .. "HP", "Hp <= X%", 20, 1, 100);

        MenuConfig['Auto']['Use W Perd'][ally.charName] = autoCharMenu:AddCheckBox(ally.charName .. "Perd", "Pred Damage >= Current HP Use");


    end

    local UseRange = Menu:AddMenu("useRange", "Use Range Settings");
    MenuConfig['Use Range']['Q'] = UseRange:AddSlider("useQRange", 'Use Q Range', 800, 1, 900, 10, function(s)
        Champions.Q = (SDKSpell.Create(SpellSlot.Q, MenuConfig['Use Range']['Q'].value, DamageType.Magical))
    end)
    MenuConfig['Use Range']['W'] = UseRange:AddSlider("useWRange", 'Use W Range', 800, 1, 800, 1, function(s)
        Champions.W = (SDKSpell.Create(SpellSlot.W, MenuConfig['Use Range']['W'].value, DamageType.Magical))
    end)
    MenuConfig['Use Range']['E'] = UseRange:AddSlider("useERange", 'Use E Range', 800, 1, 800, 1, function(s)
        Champions.E = (SDKSpell.Create(SpellSlot.E, MenuConfig['Use Range']['E'].value, DamageType.Magical))
    end)
    MenuConfig['Use Range']['R'] = UseRange:AddSlider("useRRange", 'Use R Range', 800, 1, 2000, 10, function(s)
        Champions.R = (SDKSpell.Create(SpellSlot.R, MenuConfig['Use Range']['R'].value, DamageType.Magical))
    end)

    --draw
    local draw = Menu:AddMenu("draw", "Drawing", false);

    Init();
    Champions.CreateColorMenu(draw, true)

end

LoadMenu();
local function UseQBindPred()

    if Q:Ready() then
        local SpellName = My.spellBook:GetSpellEntry(0):GetName();
        --print(SpellName)
        if SpellName == "RenataQ" then
            local T = TargetSelector.GetTarget(Q.range, DamageType.Magical);
            if T then
                if MenuConfig['Combo']['Use Q Objcet'][T.charName].value then
                    if T:IsValidTarget(Q.range) then
                        local Pred = Q:GetPrediction(T);
                        if Pred and Pred.hitchance >= HitChance.High then
                            if My.position:Distance(Pred.castPosition) <= Q.range then
                                Q:Cast(Pred.castPosition);
                            end
                        end
                    end
                end

            end


        end

    end

end

local function UseE()
    if E:Ready() then
        local T = TargetSelector.GetTarget(Q.range, DamageType.Magical);

        if T then
            if T:IsValidTarget(E.range) then
                local Pred = Q:GetPrediction(T);
                if Pred and Pred.hitchance >= HitChance.High then
                    if My.position:Distance(Pred.castPosition) <= E.range then
                        E:Cast(Pred.castPosition);
                    end
                end


            end
        end


    end


end

local function UseR()
    if R:Ready() then
        local AoePosition = R:GetCastOnBestAOEPosition(MenuConfig['Combo']['Use R Number'].value)

        if AoePosition:IsValid() then
            R:Cast(AoePosition);
        end
    end


end

local function Combo()


    if MenuConfig['Combo']['Use Q'].value then
        UseQBindPred();
    end

    if MenuConfig['Combo']['Use E'].value then
        UseE();
    end

    if MenuConfig['Combo']['Use R'].value then
        UseR();
    end
    --
    --if MenuConfig['Combo']['Use W'].value then
    --    UseWCombo();
    --end
end

local function GetEnemyQ2(T)

    for _, t in ObjectManager.enemyHeroes:pairs() do


        if T.position:Distance(t.position) <= 500 and t.networkId ~= T.networkId then
            return t;
        end

    end

    return nil;

end

local function GetTurr(Tg)


    for _, turr in ObjectManager.allyTurrets:pairs() do
        --print(My.position:Distance(turr.position))
        --print(turr.isAlive)
        if turr.isAlive and Tg.isEnemy and turr.position:Distance(Tg.position) <= 1100 then
            return turr;
        end


    end

    return nil;

end

local function UseQ2()
    --RenataQRecast  Q2
    if MenuConfig['Combo']['Use Q2'].value and Q:Ready() then
        local SpellName = My.spellBook:GetSpellEntry(0):GetName();
        if SpellName == "RenataQRecast" then
            for _, t in ObjectManager.enemyHeroes:pairs() do
                if MenuConfig['Combo']['Use Q2 Objcet'][t.charName].value then
                    if My.position:Distance(t.position) <= 1500 and t.isAlive then
                        for i, v in t.buffManager.buffs:pairs() do
                            if v.isValid then
                                if v:GetName() == 'RenataQ' then
                                    local Q2Mode = MenuConfig['Combo']['Use Q Mode'][t.charName].value;
                                    if Q2Mode == 0 then

                                        local turr = GetTurr(t);
                                        if turr then
                                            Q:Cast(turr.position);
                                            return ;
                                        else
                                            Q:Cast(My.position);
                                            return ;
                                        end

                                    end

                                    if Q2Mode == 1 then
                                        local mode_1 = GetEnemyQ2(t);
                                        if mode_1 then
                                            Q:Cast(mode_1.position);
                                            return ;
                                        else


                                            local turr = GetTurr(t);
                                            if turr then
                                                Q:Cast(turr.position);
                                                return ;
                                            else
                                                local CastPos = My.position:RelativePos(t.position, 20000)
                                                Q:Cast(CastPos);
                                                return ;
                                            end

                                        end
                                    end

                                    if Q2Mode == 2 then
                                        local mode_1 = GetEnemyQ2(t);
                                        if mode_1 then
                                            Q:Cast(mode_1.position);
                                            return ;
                                        else
                                            local turr = GetTurr(t);
                                            if turr then
                                                Q:Cast(turr.position);
                                                return ;
                                            else
                                                Q:Cast(My.position);
                                                return ;
                                            end


                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

    end
end

local function AutoWLogicHP()

    if W:Ready() then
        for _, ally in ObjectManager.allyHeroes:pairs() do

            if ally.isAlive and MenuConfig['Auto']['Use W Objcet'][ally.charName].value then
                local HpB = (ally.totalHealth / ally.totalMaxHealth) * 100;
                local SetHpB = MenuConfig['Auto']['Use W HP'][ally.charName].value;
                if HpB <= SetHpB then
                    local DamageV = HealthPrediction.GetIncomingDamage(ally, 0.1, true, true)
                    if DamageV > 50 then
                        W:Cast(ally);
                        return ;
                    end
                end

                if MenuConfig['Auto']['Use W Perd'][ally.charName].value then
                    local DamageV = HealthPrediction.GetIncomingDamage(ally, 0.1, true, true)
                    if DamageV >= ally.totalHealth - 100 then
                        W:Cast(ally);
                        return ;
                    end
                end

            end


        end
    end


end

local function ontick()
    if My.isAlive == false then
        return ;
    end

    if MenuConfig['Combo']['Use Q2'] .value then
        UseQ2();
    end

    if MenuConfig['Auto']['Auto W'].value then
        AutoWLogicHP();
    end

    if Champions.Combo then


        --print(My.totalHealth)
        --print(My.totalMaxHealth)

        Combo();

    end


    --if Champions.Harass then
    --
    --    Harass();
    --
    --end



    --Key R
    if MenuConfig['Combo']['Use Key R'].value then
        UseR();
    end

end

Callback.Bind(CallbackType.OnTick, ontick)

local fontSize = 16
Callback.Bind(CallbackType.OnImguiDraw, function()
    local dmg = HealthPrediction.GetIncomingDamage(Game.localPlayer, 0.1, true, true)
    local text = string.format("Damage: %d", dmg)
    local tX, tY = Renderer.CalcTextSize(text, fontSize)
    Renderer.DrawWorldText(text, Game.localPlayer.position, Math.Vector2(-tX / 2, 0), fontSize)
end)




