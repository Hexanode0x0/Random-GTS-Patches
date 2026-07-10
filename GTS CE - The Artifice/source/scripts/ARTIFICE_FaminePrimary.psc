scriptname ARTIFICE_FaminePrimary Extends ActiveMagicEffect

Actor Property PlayerREF Auto
Spell Property GrowFamine Auto
Weapon Property Famine0 Auto
Weapon Property Famine1 Auto
Weapon Property Famine2 Auto

Event OnEffectStart(Actor _, Actor __)
	Weapon EquippedWeap = PlayerREF.GetEquippedObject(0) as Weapon
	if EquippedWeap == Famine0 || EquippedWeap == Famine1 || EquippedWeap == Famine2
		PlayerREF.DispelSpell(GrowFamine)
	else
		GrowFamine.Cast(PlayerREF)
	endif
EndEvent

