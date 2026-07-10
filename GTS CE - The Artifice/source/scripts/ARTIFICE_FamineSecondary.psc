scriptname ARTIFICE_FamineSecondary Extends ActiveMagicEffect

Actor Property PlayerREF Auto
Spell Property ReleaseWave Auto

Event OnEffectFinish(Actor _, Actor __)
	ReleaseWave.Cast(PlayerREF)
EndEvent

