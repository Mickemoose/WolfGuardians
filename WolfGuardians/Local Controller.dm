
atom/movable
	var/tmp
		force_dir = 0
	var
		attacking=0
		isThrown=0

	Move(atom/NewLoc,Dir=0,Step_x=0,Step_y=0)
		if(attacking)
			return
		else
			Dir = force_dir||Dir
			return ..()


//PLAYER 1
button_tracker/echo
	Released(button)
		..()
		//Use this button for testing things
		/*
		if(button=="A")
			GoArrow()
		*/
		if(button=="GamepadUp" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = usr.lastdir
			walk(usr,0)
			usr.force_dir = usr.lastdir
		if(button=="GamepadDown" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = usr.lastdir
			walk(usr,0)
			usr.force_dir = usr.lastdir
		if(button=="GamepadLeft" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = usr.lastdir
			walk(usr,0)
			usr.force_dir = usr.lastdir
		if(button=="GamepadRight" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			walk(usr,0)
			usr.force_dir = usr.lastdir
		if(button=="GamepadDownRight" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			walk(usr,0)
			usr.force_dir = usr.lastdir
		if(button=="GamepadUpRight" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			walk(usr,0)
			usr.force_dir = usr.lastdir
		if(button=="GamepadDownLeft" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			walk(usr,0)
			usr.force_dir = usr.lastdir
		if(button=="GamepadUpLeft" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			walk(usr,0)
			usr.force_dir = usr.lastdir
	Pressed(button)
		..()
		if(button=="GamepadR2" &&!usr.attacking &&!usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.Jump()
		if(button=="GamepadUp" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = usr.lastdir
			walk(usr,NORTH)
		if(button=="GamepadDown" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = usr.lastdir
			walk(usr,SOUTH)
		if(button=="GamepadLeft" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = WEST
			usr.lastdir=WEST
			walk(usr,WEST)
		if(button=="GamepadRight" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = EAST
			usr.lastdir=EAST
			walk(usr,EAST)
		if(button=="GamepadDownRight" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = EAST
			usr.lastdir=EAST
			walk(usr,SOUTHEAST)
		if(button=="GamepadUpRight" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = EAST
			usr.lastdir=EAST
			walk(usr,NORTHEAST)
		if(button=="GamepadDownLeft" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = WEST
			usr.lastdir=WEST
			walk(usr,SOUTHWEST)
		if(button=="GamepadUpLeft" && !usr.attacking &&usr.gameScreen!="CSS"&&!usr.isThrown)
			usr.force_dir = WEST
			usr.lastdir=WEST
			walk(usr,NORTHWEST)

//PLAYER 2
button_tracker/echo
	Released(button)
		..()
		for(var/mob/players/Player2/P2 in world)
			if(button=="Gamepad2Up" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2Down" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2Left" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = P2.lastdir
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2Right" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2DownRight" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2UpRight" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2DownLeft" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				walk(P2,0)
				P2.force_dir = P2.lastdir
			if(button=="Gamepad2UpLeft" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				walk(P2,0)
				P2.force_dir = P2.lastdir
	Pressed(button)
		..()
		for(var/mob/players/Player2/P2 in world)
			if(button=="Gamepad2R2" &&!P2.attacking &&!usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.Jump()
			if(button=="Gamepad2Up" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = P2.lastdir
				walk(P2,1)
			if(button=="Gamepad2Down" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = P2.lastdir
				walk(P2,SOUTH)
			if(button=="Gamepad2Left" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,WEST)
			if(button=="Gamepad2Right" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,EAST)
			if(button=="Gamepad2DownRight" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,SOUTHEAST)
			if(button=="Gamepad2UpRight" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = EAST
				P2.lastdir=EAST
				walk(P2,NORTHEAST)
			if(button=="Gamepad2DownLeft" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,SOUTHWEST)
			if(button=="Gamepad2UpLeft" && !P2.attacking &&usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.force_dir = WEST
				P2.lastdir=WEST
				walk(P2,NORTHWEST)
			if(button=="Gamepad2Face3"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isThrown&&!P2.isJumping)
				if(P2.comboCount==0)
					P2.damage=P2.damage
				if(P2.comboCount==1)
					P2.damage=P2.damage
				if(P2.comboCount==2)
					P2.damage=P2.damage+2
				P2.Combo()
			if(button=="Gamepad2Face2"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isThrown&&!P2.isJumping)
				P2.Grab()
				P2.Activate()
			if(button=="Gamepad2Face4"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isThrown&&!P2.isJumping)
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
			if(button=="Gamepad3R2" &&!P2.attacking &&!usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.Jump()
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
			if(button=="Gamepad3Face3"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isJumping)
				if(P2.comboCount==0)
					P2.damage=P2.damage
				if(P2.comboCount==1)
					P2.damage=P2.damage
				if(P2.comboCount==2)
					P2.damage=P2.damage+2
				P2.Combo()
			if(button=="Gamepad3Face2"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isJumping)
				P2.Grab()
				P2.Activate()
			if(button=="Gamepad3Face4"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isJumping)
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
			if(button=="Gamepad4R2" &&!P2.attacking &&!usr.gameScreen!="CSS"&&!P2.isThrown)
				P2.Jump()
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
			if(button=="Gamepad4Face3"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isJumping)
				if(P2.comboCount==0)
					P2.damage=P2.damage
				if(P2.comboCount==1)
					P2.damage=P2.damage
				if(P2.comboCount==2)
					P2.damage=P2.damage+2
				P2.Combo()
			if(button=="Gamepad4Face2"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isJumping)
				P2.Grab()
				P2.Activate()
			if(button=="Gamepad4Face4"&&!P2.attacking&&usr.gameScreen!="CSS"&&!P2.isJumping)
				P2.Morph()
