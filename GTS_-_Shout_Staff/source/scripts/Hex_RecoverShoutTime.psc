Scriptname Hex_RecoverShoutTime Extends ActiveMagicEffect

Int Property CooldownReduction Auto

Event OnEffectStart(Actor _, Actor Caster)
	float cooldown = Caster.GetVoiceRecoveryTime()
	if cooldown == 0
		return
	endif
	if cooldown > CooldownReduction
		Caster.SetVoiceRecoveryTime(cooldown - CooldownReduction)
	else
		Caster.SetVoiceRecoveryTime(0)
	endif
EndEvent
