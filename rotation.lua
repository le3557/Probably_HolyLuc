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
  { "19740", "!player.buff(19740)" }, --Blessing of Migth
  { "31801", "player.seal != 3" }, --Seal of Truth

  -- tank
  { "53563", "!tank.buff(53563)" }, --Beacon Of Light
  
  -- Interrupts
  { "96231", "modifier.interrupts" }, --Rebuke

  -- mana regen
  { "54428", "player.mana < 80" }, --Divine Plea

  -- T6 Tallents
  { "114165", "lowest.health < 85"  }, --Holy Prism
  { "114158" , "modifier.lcontrol", "ground" }, --Light's Hammer
  { "114157", "lowest.health < 85"  }, --Execution Sentence

  -- CDs
  { "31842" , "modifier.lshift" }, --Divine Favor
  { "31884" , "modifier.lalt" }, --Avenging Wrath
  { "86669" , "modifier.rshift" }, --Guardian of Ancient King

  -- Dispell
  { "4987", "@coreHealing.needsDispelled('Aqua Bomb')" }, --Cleanse

  -- regular healing
  { "633", "lowest.health < 20" }, --Lay on Hands
  { "20473", "lowest.health < 100" }, --Holy Shock
  { "85222", { "@coreHealing.needsHealing(90, 4)", "player.holypower >= 3" }, "lowest" }, --Light Of Dawn
  { "19750", "lowest.health < 40" }, --Flash of Light
  { "20925", { "!lowest.buff", "lowest.health < 50" }}, --Sacred Shield
  { "85673", "player.holypower >= 1", "lowest.health < 70" }, --Word Of Glory
  { "82326", "lowest.health < 60" }, --Divine Light
  { "82327", "@coreHealing.needsHealing(80, 4)", "lowest" }, --Holy Radiance
  { "635", "lowest.health < 90" }, --Holy Light

})
