-- ProbablyEngine Rotation Packager
-- Custom Protection Paladin Rotation
-- Created on Nov 10th 2013 1:08 am
ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.rotation.register_custom(65, "HolyLuc", {

  -- buffs
  { "Blessing of Might", "!player.buff(Blessing of Might)" },
  { "Seal of Truth", "player.seal != 3" },

  -- tank
  { "Beacon Of Light", "!tank.buff" },
  
  -- Interrupts
  { "Rebuke", "modifier.interrupts" },

  -- mana regen
  { "Divine Plea", "player.mana < 80" },

  -- T6 Tallents
  { "Holy Prism", "lowest.health < 85"  },
  { "Light's Hammer" , "modifier.lcontrol", "ground" },
  { "Execution Sentence", "lowest.health < 85"  },

  -- CDs
  { "Divine Favor" , "modifier.lshift" },
  { "Avenging Wrath" , "modifier.lalt" },
  { "Guardian of Ancient King" , "modifier.rshift" },

  -- Dispell
  { "Cleanse", "@coreHealing.needsDispelled('Aqua Bomb')" },

  -- regular healing
  { "Lay on Hands", "lowest.health < 20" },
  { "Holy Shock", "lowest.health < 100" },
  { "Flash of Light", "lowest.health < 40" },
  { "Sacred Shield", { "!lowest.buff", "lowest.health < 50" }},
  { "Divine Light", "lowest.health < 70" },
  { "Light Of Dawn", { "@coreHealing.needsHealing(90, 4)", "player.holypower >= 3" }, "lowest" },
  { "Word Of Glory", "player.holypower >= 1", "lowest.health < 70" },
  { "Holy Radiance", "@coreHealing.needsHealing(80, 4)", "lowest" },
  { "Holy Light", "lowest.health < 90" },

})
