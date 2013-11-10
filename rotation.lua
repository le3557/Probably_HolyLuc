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
  { "Beacon Of Light", "!tank.buff(Beacon Of Light)" },
  { "Sacred Shield", { "!tank.buff(Sacred shield)", "tank.health < 50" } },

  -- Interrupts
  { "Rebuke", "modifier.interrupts" },

  -- mana regen
  { "Divine Plea", "player.mana < 80" },

  -- CDs
  { "Divine Favor" , "modifier.lshift" },
  { "Avenging Wrath" , "modifier.lalt" },

  -- Dispell
  { "Cleanse", "@coreHealing.needsDispelled('Aqua Bomb')" },

  -- regular healing
  { "Holy Shock", "lowest.health < 100"},
  { "Flash of Light", "lowest.health < 20" },
  { "Divine Light", "lowest.health < 60"},
  { "Light Of Dawn", { "@coreHealing.needsHealing(90, 4)", "player.holypower >= 3" } },
  { "Holy Radiance", "@coreHealing.needsHealing(85, 4)", "lowest" },
  { "World Of Glory", "player.holypower >= 1", "lowest.health < 90" },
  { "Holy Light", "lowest.health < 80" },

  -- T6 Tallents
  { "Holy Prism", "lowest.health < 85"  },
  { "Light's Hammer" , "modifier.lcontrol", "ground" },
  { "Execution Sentence", "lowest.health < 85"  },

})