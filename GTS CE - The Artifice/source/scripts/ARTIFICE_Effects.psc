scriptname ARTIFICE_Effects Extends ActiveMagicEffect

import PO3_Events_AME

Actor Property PlayerREF Auto

FormList Property EffectKeywords Auto

Spell[] Property ArtificeSpellsImpure Auto
Spell[] Property ArtificeSpellsStandard Auto
Spell[] Property ArtificeSpellsPure Auto

int ArtificeSpellLevel = 0

float magickaBoost = 0.0

Event OnEffectStart(Actor _, Actor __)
	RegisterForHitEventEx(self)
	RegisterForMagicEffectApplyEx(self, EffectKeywords, true)
	AddArtificeSpells(ArtificeSpellLevel)
	RegisterForModEvent("ARTIFICE_IncreaseMagicka", "ARTIFICE_OnMagickaIncrease")
	RegisterForModEvent("ARTIFICE_ChangeSpellLevel", "ARTIFICE_OnSpellLevelChange")
	PlayerREF.ModActorValue("Magicka", magickaBoost)
EndEvent

Event OnEffectFinish(Actor _, Actor __)
	UnregisterForHitEventEx(self)
	UnregisterForAllMagicEffectApplyEx(self)
	RemoveArtificeSpells(ArtificeSpellLevel)
	UnRegisterForModEvent("ARTIFICE_IncreaseMagicka")
	PlayerREF.ModActorValue("Magicka", (magickaBoost * -1))
EndEvent

Event OnHitEx(ObjectReference Aggressor, Form Source, Projectile Proj, bool PowerAttack, bool SneakAttack, bool BashAttack, bool HitBlocked)
	If Aggressor == PlayerREF || HitBlocked || BashAttack
		return
	endif
	PlayerREF.RestoreActorValue("Magicka", 20)
EndEvent

Event OnMagicEffectApplyEx(ObjectReference Caster, MagicEffect Effect, Form Source, bool Applied)
	if !Applied
		return
	endif
	if Effect.HasKeyword(EffectKeywords.GetAt(0) as Keyword) || Effect.HasKeyword(EffectKeywords.GetAt(1) as Keyword) || Effect.HasKeyword(EffectKeywords.GetAt(2) as Keyword) || Effect.HasKeyword(EffectKeywords.GetAt(3) as Keyword) || Effect.HasKeyword(EffectKeywords.GetAt(4) as Keyword)
		if Effect.GetCastingType() == 2
			PlayerREF.RestoreActorValue("Magicka", 5)
		else
			PlayerREF.RestoreActorValue("Magicka", 50)
		endif
	elseif Effect.HasKeyword(EffectKeywords.GetAt(5) as Keyword)
		PlayerREF.RestoreActorValue("Magicka", 50)
	endif
EndEvent

Event ARTIFICE_OnMagickaIncrease(float ByHowMuch)
	magickaBoost = magickaBoost + ByHowMuch
	PlayerREF.ModActorValue("Magicka", ByHowMuch)
EndEvent

Event ARTIFICE_OnSpellLevelChange(int lvl)
	RemoveArtificeSpells(lvl - 1)
	AddArtificeSpells(lvl)
	ArtificeSpellLevel = lvl
EndEvent

Function AddArtificeSpells(int level)
	if level < 1
		int i = 0
		while i < ArtificeSpellsImpure.Length
			PlayerREF.AddSpell(ArtificeSpellsImpure[i], false)
			i = i + 1
		endwhile
	elseif level == 1
		int i = 0
		while i < ArtificeSpellsStandard.Length
			PlayerREF.AddSpell(ArtificeSpellsStandard[i], false)
			i = i + 1
		endwhile
	elseif level > 1
		int i = 0
		while i < ArtificeSpellsPure.Length
			PlayerREF.AddSpell(ArtificeSpellsPure[i], false)
			i = i + 1
		endwhile
	endif
EndFunction

Function RemoveArtificeSpells(int level)
	if level < 1
		int i = 0
		while i < ArtificeSpellsImpure.Length
			PlayerREF.RemoveSpell(ArtificeSpellsImpure[i])
			i = i + 1
		endwhile
	elseif level == 1
		int i = 0
		while i < ArtificeSpellsStandard.Length
			PlayerREF.RemoveSpell(ArtificeSpellsStandard[i])
			i = i + 1
		endwhile
	elseif level > 1
		int i = 0
		while i < ArtificeSpellsPure.Length
			PlayerREF.RemoveSpell(ArtificeSpellsPure[i])
			i = i + 1
		endwhile
	endif
EndFunction
