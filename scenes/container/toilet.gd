extends ItemContainer

func hit():
	if not opened:		
		$LidSprite.hide()
		
		for i in range(2):
			var pos = $SpawnPositions.get_children().pick_random().global_position
			open.emit(pos, currenct_direction)
		
		opened = true