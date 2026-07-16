scriptname ARTIFICE_Effects Extends ActiveMagicEffect

import PO3_Events_AME

Actor Property PlayerREF Auto

FormList Property EffectKeywords Auto

Keyword Property VendorItemPotion Auto

Spell[] Property ArtificeSpellsImpure Auto
Spell[] Property ArtificeSpellsStandard Auto
Spell[] Property ArtificeSpellsPure Auto

int ArtificeSpellLevel = 0

float magickaBoost = 0.0

Event OnEffectStart(Actor _, Actor __)
	RegisterForHitEventEx(self)
	RegisterForMagicEffectApplyEx(self, EffectKeywords, true)
	RegisterForSoulTrapped(self)
	AddArtificeSpells(ArtificeSpellLevel)
	RegisterForModEvent("ARTIFICE_IncreaseMagicka", "ARTIFICE_OnMagickaIncrease")
	RegisterForModEvent("ARTIFICE_ChangeSpellLevel", "ARTIFICE_OnSpellLevelChange")
	PlayerREF.ModActorValue("Magicka", magickaBoost)
EndEvent

Event OnEffectFinish(Actor _, Actor __)
	UnregisterForHitEventEx(self)
	UnregisterForAllMagicEffectApplyEx(self)
	UnregisterForSoulTrapped(self)
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

Event OnSoulTrapped(Actor _, Actor killer)
	if killer == PlayerREF
		PlayerREF.RestoreActorValue("Magicka", 100)
	endif
EndEvent

Event OnObjectEquipped(Form Item, ObjectReference Ref)
	if Item as ingredient
		PlayerREF.RestoreActorValue("Magicka", 20)
	elseif item as potion && item.HasKeyword(VendorItemPotion)
		PlayerREF.RestoreActorValue("Magicka", 100)
	endif
EndEvent

Event OnMagicEffectApplyEx(ObjectReference Caster, MagicEffect Effect, Form Source, bool Applied)
	if !Applied
		return
	endif
	if Effect.GetCastingType() == 2
		PlayerREF.RestoreActorValue("Magicka", 5)
	else
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
