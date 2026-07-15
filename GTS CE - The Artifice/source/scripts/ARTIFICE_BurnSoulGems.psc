scriptname ARTIFICE_BurnSoulGems extends ObjectReference

Actor Property PlayerREF Auto

Event OnItemAdded(Form Item, int Count, ObjectReference Ref, ObjectReference Source)
	if Ref != None
		RemoveItem(Ref, Count, false, Source)
		return
	endif
	if !(Item as SoulGem)
		RemoveItem(Item, Count, false, Source)
		return
	endif
	int soulSize = (Item as SoulGem).GetSoulSize() * Count
	if soulSize > 0
		PlayerREF.RestoreActorValue("Magicka", soulSize * 50)
	endif
	;debug.notification(Item.GetName() + " Soul: " + (Item as SoulGem).GetSoulSize() as string + " Gem: " + (Item as SoulGem).GetGemSize() as string)
	int handle = ModEvent.Create("ARTIFICE_IncreaseMagicka")
	ModEvent.Send(handle)
	RemoveItem(Item, Count)
EndEvent
