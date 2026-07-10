scriptname ARTIFICE_Level Extends ActiveMagicEffect

int Property Level Auto

Event OnEffectStart(Actor _, Actor __)
	int handle = ModEvent.Create("ARTIFICE_ChangeSpellLevel")
	ModEvent.PushInt(handle, Level)
	ModEvent.Send(handle)
EndEvent

