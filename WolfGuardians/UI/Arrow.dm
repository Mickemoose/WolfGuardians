UI

	Arrow
		icon='UI/Arrow.dmi'
		screen_loc="EAST-5, CENTER"
		New()
			..()
			animate(src, transform = matrix()*4, time = 0)

proc
	GoArrow()
		var/UI/Arrow/A=new/UI/Arrow(usr.client)
		world<<go
		spawn(3)
			A.invisibility=101
			spawn(3)
				A.invisibility=0
				world<<go
				spawn(3)
					A.invisibility=101
					spawn(3)
						A.invisibility=0
						world<<go
						spawn(3)
							A.invisibility=101
							spawn(3)
								A.invisibility=0
								world<<go
								spawn(3)
									del A
	KillCheck()
		for(var/area/KILL_WALL/K in world)
			if(K.isLocked && global.kills == K.killsRequired)
				K.Unlock()
				break