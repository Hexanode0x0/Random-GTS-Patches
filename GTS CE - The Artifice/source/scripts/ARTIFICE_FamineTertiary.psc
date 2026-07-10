scriptname ARTIFICE_FamineTertiary Extends ActiveMagicEffect

Actor Property PlayerREF Auto

float magnitude

Event OnInit()
	magnitude = self.GetMagnitude()
EndEvent

Event OnEffectStart(Actor _, Actor __)
	PlayerREF.RestoreActorValue("Magicka", magnitude) 
EndEvent

