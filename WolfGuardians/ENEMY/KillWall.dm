area
	KILL_WALL
		var
			killsRequired = 0
			isLocked=1
		proc
			Unlock()
				world.log << "[src] UNLOCKED"
				if(isLocked)
					if(global.kills == killsRequired)
						isLocked=0
						GoArrow()

		WALL_1
			killsRequired=1
		WALL_2
			killsRequired=2
		WALL_5
			killsRequired=5
		WALL_10
			killsRequired=10
		WALL_12
			killsRequired=12
		WALL_15
			killsRequired=15
		WALL_20
			killsRequired=20
		WALL_25
			killsRequired=25
		Enter(mob/m)
			if(isLocked)
				return 0
			else
				return 1
