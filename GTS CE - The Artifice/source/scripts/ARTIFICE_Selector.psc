scriptname ARTIFICE_Selector Extends ActiveMagicEffect

import b612

Message Property ReweaveMsg Auto
ObjectReference Property SoulGemBurner Auto
Actor Property PlayerREF Auto

;These arrays MUST be aligned
ConstructibleObject[] Property ConstructionData Auto
Spell[] Property ConstructionResults Auto

Event OnEffectStart(Actor _, Actor __)
	int result = ReweaveMsg.Show()
	if result == 0
		Game.ShowLimitedRaceMenu()
	elseif result == 1
		ShowCraftMenu()
	elseif result == 2
		SoulGemBurner.Activate(PlayerREF)
	elseif result == 3
		return
	endif
EndEvent

Function ShowCraftMenu()
	int[] aux = new int[50]
	GetSpinicon().Show("Waiting for you...")
	Game.DisablePlayerControls(true, true, false, true, true, true, true)
	b612_TraitsMenu CraftMenu = GetTraitsMenu()
	int i = 0
	int j = 0
	while i < ConstructionResults.Length
		if !PlayerREF.HasMagicEffect(ConstructionResults[i].GetNthEffectMagicEffect(0)) && (PlayerREF.HasKeyword(ConstructionData[i].GetWorkbenchKeyword()) || PlayerREF.HasMagicEffectWithKeyword(ConstructionData[i].GetWorkbenchKeyword()))
			string construstionDataString = ""
			int l = 0
			while l < ConstructionData[i].GetNumIngredients()
				Form ingr = ConstructionData[i].GetNthIngredient(l)
				construstionDataString = construstionDataString + ingr.GetName() + " (" + PlayerREF.GetItemCount(ingr) as String + "/" + ConstructionData[i].GetNthIngredientQuantity(l) as String + ")<br>"
				l = l + 1
			endwhile
			CraftMenu.AddItem(ConstructionResults[i].GetName(), construstionDataString, "")
			aux[j] = i
			j = j + 1
		endif
		i = i + 1
	endwhile
	GetSpinicon().Hide()
	Game.EnablePlayerControls()
	string[] tempResult
	tempResult = CraftMenu.Show(1, 0)
	if tempResult.Length < 1
		return
	endif
	int tempResult2 = tempResult[0] as int
	int result = aux[tempResult2]
	if PlayerREF.HasMagicEffect(ConstructionResults[result].GetNthEffectMagicEffect(0))
		debug.notification("ERROR: The player already has " + ConstructionResults[result].GetName())
		return
	endif
	;check if we have the ingredients
	int l = 0
	while l < ConstructionData[result].GetNumIngredients()
		Form ingr = ConstructionData[result].GetNthIngredient(l)
		if PlayerREF.GetItemCount(ingr) < ConstructionData[result].GetNthIngredientQuantity(l)
			Debug.MessageBox("Insufficient Ingredients")
			return
		endif
		l = l + 1
	endwhile
	;actually take the ingredients
	l = 0
	while l < ConstructionData[result].GetNumIngredients()
		PlayerREF.RemoveItem(ConstructionData[result].GetNthIngredient(l), ConstructionData[result].GetNthIngredientQuantity(l))
		l = l + 1
	endwhile
	PlayerREF.addSpell(ConstructionResults[result])
EndFunction
