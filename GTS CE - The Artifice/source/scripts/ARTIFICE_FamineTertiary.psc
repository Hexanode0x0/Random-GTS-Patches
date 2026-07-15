scriptname ARTIFICE_FamineTertiary Extends ActiveMagicEffect

Actor Property PlayerREF Auto

Event OnEffectStart(Actor _, Actor __)
	PlayerREF.RestoreActorValue("Magicka", self.GetMagnitude())
EndEvent

