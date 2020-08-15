
atom/movable
    var/tmp
        force_dir = 0

    Move(atom/NewLoc,Dir=0,Step_x=0,Step_y=0)
        Dir = force_dir||Dir
        return ..()

//PLAYER 2
button_tracker/echo
	Released(button)
		..()
		for(var/mob/players/Player2/P2 in world)
			if(button=="Gamepad2Up" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2Down" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2Left" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2Right" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2DownRight" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2UpRight" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2DownLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2UpLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
	Pressed(button)
		..()
		for(var/mob/players/Player2/P2 in world)
			if(button=="Gamepad2Up" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,1)
			if(button=="Gamepad2Down" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,SOUTH)
			if(button=="Gamepad2Left" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,WEST)
			if(button=="Gamepad2Right" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,EAST)
			if(button=="Gamepad2DownRight" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,SOUTHEAST)
			if(button=="Gamepad2UpRight" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,NORTHEAST)
			if(button=="Gamepad2DownLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,SOUTHWEST)
			if(button=="Gamepad2UpLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,NORTHWEST)
			if(button=="Gamepad2Face3"&&!P2.attacking&&usr.gameScreen!="CSS")
				P2.Combo()
			if(button=="Gamepad2Face2"&&!P2.attacking&&usr.gameScreen!="CSS")
				P2.Grab()
				P2.Activate()
			if(button=="Gamepad2Face4"&&!usr.attacking&&usr.gameScreen!="CSS")
				P2.Morph()

//PLAYER 3
button_tracker/echo
	Released(button)
		..()
		for(var/mob/players/Player3/P2 in world)
			if(button=="Gamepad3Up" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad3Down" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad3Left" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad3Right" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad3DownRight" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad3UpRight" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad3DownLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad3UpLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
	Pressed(button)
		..()
		for(var/mob/players/Player3/P2 in world)
			if(button=="Gamepad3Up" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,1)
			if(button=="Gamepad3Down" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,SOUTH)
			if(button=="Gamepad3Left" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,WEST)
			if(button=="Gamepad3Right" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,EAST)
			if(button=="Gamepad3DownRight" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,SOUTHEAST)
			if(button=="Gamepad3UpRight" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,NORTHEAST)
			if(button=="Gamepad3DownLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,SOUTHWEST)
			if(button=="Gamepad3UpLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,NORTHWEST)
			if(button=="Gamepad3Face3"&&!P2.attacking&&usr.gameScreen!="CSS")
				P2.Combo()
			if(button=="Gamepad3Face2"&&!P2.attacking&&usr.gameScreen!="CSS")
				P2.Grab()
				P2.Activate()
			if(button=="Gamepad3Face4"&&!usr.attacking&&usr.gameScreen!="CSS")
				P2.Morph()

//PLAYER 4
button_tracker/echo
	Released(button)
		..()
		for(var/mob/players/Player4/P2 in world)
			if(button=="Gamepad4Up" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad4Down" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad4Left" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad4Right" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad4DownRight" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad4UpRight" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad4DownLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad4UpLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				walk(P2,0)
				P2.force_dir = P2.lastdir
	Pressed(button)
		..()
		for(var/mob/players/Player2/P2 in world)
			if(button=="Gamepad4Up" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,1)
			if(button=="Gamepad4Down" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = P2.lastdir
				walk(P2,SOUTH)
			if(button=="Gamepad4Left" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,WEST)
			if(button=="Gamepad4Right" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,EAST)
			if(button=="Gamepad4DownRight" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,SOUTHEAST)
			if(button=="Gamepad4UpRight" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,NORTHEAST)
			if(button=="Gamepad4DownLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,SOUTHWEST)
			if(button=="Gamepad4UpLeft" && !P2.attacking &&usr.gameScreen!="CSS")
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,NORTHWEST)
			if(button=="Gamepad4Face3"&&!P2.attacking&&usr.gameScreen!="CSS")
				P2.Combo()
			if(button=="Gamepad4Face2"&&!P2.attacking&&usr.gameScreen!="CSS")
				P2.Grab()
				P2.Activate()
			if(button=="Gamepad4Face4"&&!usr.attacking&&usr.gameScreen!="CSS")
				P2.Morph()
