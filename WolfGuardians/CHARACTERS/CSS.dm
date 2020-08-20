mob
	players
		icon='CHARACTERS/Selectors.dmi'
		Player1
		Player2
			icon_state="P2"
			move_speed=4
		Player3

			icon_state="P3"
			move_speed=4
		Player4
			icon_state="P4"
			move_speed=4
		Move()
			..()
	proc
		LeaderScan()
			while(src.leader)
				world.log << "\n LEADER"
				for(var/mob/players/M in activePlayers)
					if(get_dist(src,M)<=7.5 ||M==src)
						world.log << "\n NO"
						continue

					else
						world.log << "\n [M] TELEPORTS TO [src]"
						M.Teleport()
					break
				sleep(10)
		Teleport()
			for(var/mob/M in activePlayers)
				if(M.leader)
					animate(src,color=rgb(0,0,255),time=1)
					src.loc=M.loc
					spawn(1)
						animate(src,color=rgb(255,255,255),time=2)
						return

	pressStart
		appearance_flags = PIXEL_SCALE
		icon='CHARACTERS/PressStart.dmi'
		invisibility=101
	people
		appearance_flags = PIXEL_SCALE
		dir=EAST
		Player1
		Player2
		Player3
		Player4
	names
		appearance_flags = PIXEL_SCALE
		icon='CHARACTERS/Names.dmi'
		Player1
		Player2
		Player3
		Player4
	portraits
		appearance_flags = PIXEL_SCALE
		icon='CHARACTERS/Portraits.dmi'
		Player1
			icon_state="P1-lock"
		Player2
			icon_state="P2-lock"
		Player3
			icon_state="P3-lock"
		Player4
			icon_state="P4-lock"
	selectors
		plane=2
		appearance_flags = PIXEL_SCALE
		icon='CHARACTERS/Selectors.dmi'
		New()
			animate(src, transform = matrix()*4, time = 0)
		var
			slot=0
			list
				hovering = list()
		Player1
			icon_state="P1"
		Player2
			icon_state="P2"
		Player3
			icon_state="P3"
		Player4
			icon_state="P4"
obj
	css
		plane=2
		appearance_flags = PIXEL_SCALE
		var
			character
			clip
		derek
			icon='CHARACTERS/Derek.dmi'
			icon_state="icon"
			clip=sound('DEREK.wav')
			character="DEREK"
		brendan
			icon='CHARACTERS/Brendan.dmi'
			icon_state="icon"
			clip=sound('BRENDAN.wav')
			character="BRENDAN"
		New()
			animate(src, transform = matrix()*4, time = 0)
			playableCharacters.Add(src)

mob
	proc
		PlayerCheck()
			if(playerCount==activePlayers.len&&playerCount>=1)
				for(var/mob/pressStart/PS in world)
					PS.invisibility=0

				return 1
			else
				for(var/mob/pressStart/PS in world)
					PS.invisibility=101
				return 0
		CSS_Start()
			src.loc=locate(44,39,2)
			src<<css
			src.gameScreen="CSS"
			src<<csstitle
			for(var/mob/M in world)
				M.active=0
				M.selected=0
				M.selecting=0
				M.UnPickCharacter()
			for(var/mob/selectors/P in world)
				del(P)
			for(var/mob/people/PP in world)
				PP.icon_state=null
				PP.icon=null
			for(var/mob/portraits/Player1/P1 in world)
				P1.icon_state="P1-lock"
			for(var/mob/portraits/Player2/P2 in world)
				P2.icon_state="P3-lock"
			for(var/mob/portraits/Player3/P3 in world)
				P3.icon_state="P3-lock"
			for(var/mob/portraits/Player4/P4 in world)
				P4.icon_state="P4-lock"
			playerCount=0
			activePlayers.Remove(activePlayers)
			PlayerCheck()
		PickCharacter(character)
			src.invisibility=101
			src.damage=5
			if(character=="DEREK")
				src.icon='CHARACTERS/Derek.dmi'
				src.guardian="RED"
				src.gicon = file('CHARACTERS/Red.dmi')
				src.icon_state="Idle"
				src.dir=EAST
				src.lastdir=EAST
			if(character=="BRENDAN")
				src.icon='CHARACTERS/Brendan.dmi'
				src.guardian="PURPLE"
				src.gicon = file('CHARACTERS/Red.dmi')
				src.icon_state="Idle"
				src.dir=EAST
				src.lastdir=EAST
			PlayerCheck()

		UnPickCharacter()

			src.character=null
			src.icon=null
			src.guardian=null
			src.gicon=null
			src.icon_state=null
			src.dir=null
			src.lastdir=null
			src.bound_width=32
			src.bound_height=32
			src.bound_x=0
			PlayerCheck()

button_tracker/echo
	Pressed(button)
		..()
		//PLAYER 4
		if(button=="Gamepad4Start" &&usr.gameScreen=="CSS")
			for(var/mob/players/Player4/M in world)
				if(!M.active && !M.selected)
					M.active=1
					M.playerNumber=4
					playerCount++
					var/mob/selectors/Player4/P1 = new
					P1.loc=locate(52,28,2)
					P1.slot=4
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player4/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player4/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					for(var/mob/portraits/Player4/P in world)
						P.icon_state="P4"
					usr.PlayerCheck()
					return

				if(M.active && !M.selected)
					for(var/mob/selectors/Player4/P1 in world)
						del P1
					M.active=0
					playerCount--
					for(var/mob/portraits/Player4/P in world)
						P.icon_state="P4-lock"
					for(var/mob/names/Player4/n2 in world)
						n2.icon_state=null
					for(var/mob/people/Player4/pp1 in world)
						pp1.icon=null
					usr.PlayerCheck()
					return

		for(var/mob/players/Player4/M in world)
			if(button=="Gamepad4Face3"&&usr.gameScreen=="CSS"&&M.selected&&!M.selecting)
				for(var/mob/selectors/Player4/P1 in world)
					M.selected=0
					usr<<cancel
					activePlayers.Remove(M)
					M.UnPickCharacter()
					P1.icon_state="P4"

					for(var/mob/people/Player4/pp1 in world)
						pp1.icon_state="Idle"
			if(button=="Gamepad4Face2"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player4/P1 in world)
					M.selecting=1
					M.selected=1
					usr<<select

					flick("P4-select",P1)
					spawn(6)
						P1.icon_state="P4-selected"
					spawn(10)
						M.selecting=0
					for(var/obj/css/c in P1.hovering)
						M.character=c.character
						world<<c.clip
						activePlayers.Add(M)
						M.PickCharacter(M.character)
					for(var/mob/people/Player4/pp1 in world)
						flick("Power",pp1)
						spawn(1)
							usr<<punch
						spawn(3)
							pp1.icon_state="Show"
			if(button=="Gamepad4Left"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player4/P1 in world)
					usr<<menubutton
					if(P1.slot==1||P1.slot==6)
						P1.x+=32
						P1.slot+=4
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player4/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player4/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
					else
						P1.x-=8
						P1.slot--
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player4/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player4/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad4Right"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player4/P1 in world)
					usr<<menubutton
					if(P1.slot==5||P1.slot==10)
						P1.x-=32
						P1.slot-=4
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player4/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player4/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
					else
						P1.x+=8
						P1.slot++
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player4/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player4/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad4Up"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player4/P1 in world)
					usr<<menubutton
					if(P1.slot>=6&&P1.slot<=10)
						P1.y+=8
						P1.slot-=5
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player4/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player4/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad4Down"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player4/P1 in world)
					usr<<menubutton
					if(P1.slot>=1&&P1.slot<=6)
						P1.y-=8
						P1.slot+=5
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player4/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player4/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
		//PLAYER 3
		if(button=="Gamepad3Start" &&usr.gameScreen=="CSS")
			for(var/mob/players/Player3/M in world)
				if(!M.active && !M.selected)
					M.active=1
					M.playerNumber=3
					playerCount++
					var/mob/selectors/Player3/P1 = new
					P1.loc=locate(44,28,2)
					P1.slot=3
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player3/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player3/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					for(var/mob/portraits/Player3/P in world)
						P.icon_state="P3"
					usr.PlayerCheck()
					return

				if(M.active && !M.selected)
					for(var/mob/selectors/Player3/P1 in world)
						del P1
					M.active=0
					playerCount--
					for(var/mob/portraits/Player3/P in world)
						P.icon_state="P3-lock"
					for(var/mob/names/Player3/n2 in world)
						n2.icon_state=null
					for(var/mob/people/Player3/pp1 in world)
						pp1.icon=null
					usr.PlayerCheck()
					return

		for(var/mob/players/Player3/M in world)
			if(button=="Gamepad3Face3"&&usr.gameScreen=="CSS"&&M.selected&&!M.selecting)
				for(var/mob/selectors/Player3/P1 in world)
					M.selected=0
					usr<<cancel
					activePlayers.Remove(M)
					M.UnPickCharacter()
					P1.icon_state="P3"

					for(var/mob/people/Player3/pp1 in world)
						pp1.icon_state="Idle"
			if(button=="Gamepad3Face2"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player3/P1 in world)
					M.selecting=1
					M.selected=1
					usr<<select

					flick("P3-select",P1)
					spawn(6)
						P1.icon_state="P3-selected"
					spawn(10)
						M.selecting=0
					for(var/obj/css/c in P1.hovering)
						M.character=c.character
						world<<c.clip
						activePlayers.Add(M)
						M.PickCharacter(M.character)
					for(var/mob/people/Player3/pp1 in world)
						flick("Power",pp1)
						spawn(1)
							usr<<punch
						spawn(3)
							pp1.icon_state="Show"
			if(button=="Gamepad3Left"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player3/P1 in world)
					usr<<menubutton
					if(P1.slot==1||P1.slot==6)
						P1.x+=32
						P1.slot+=4
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player3/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player3/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
					else
						P1.x-=8
						P1.slot--
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player3/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player3/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad3Right"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player3/P1 in world)
					usr<<menubutton
					if(P1.slot==5||P1.slot==10)
						P1.x-=32
						P1.slot-=4
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player3/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player3/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
					else
						P1.x+=8
						P1.slot++
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player3/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player3/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad3Up"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player3/P1 in world)
					usr<<menubutton
					if(P1.slot>=6&&P1.slot<=10)
						P1.y+=8
						P1.slot-=5
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player3/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player3/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad3Down"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player3/P1 in world)
					usr<<menubutton
					if(P1.slot>=1&&P1.slot<=6)
						P1.y-=8
						P1.slot+=5
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player3/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player3/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
		//PLAYER 2
		if(button=="Gamepad2Start" &&usr.gameScreen=="CSS")
			for(var/mob/players/Player2/M in world)
				if(!M.active && !M.selected)
					M.active=1
					M.playerNumber=2
					playerCount++
					var/mob/selectors/Player2/P1 = new
					P1.loc=locate(36,28,2)
					P1.slot=2
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player2/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player2/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					for(var/mob/portraits/Player2/P in world)
						P.icon_state="P2"
					usr.PlayerCheck()
					return

				if(M.active && !M.selected)
					for(var/mob/selectors/Player2/P1 in world)
						del P1
					M.active=0
					playerCount--
					for(var/mob/portraits/Player2/P in world)
						P.icon_state="P2-lock"
					for(var/mob/names/Player2/n2 in world)
						n2.icon_state=null
					for(var/mob/people/Player2/pp1 in world)
						pp1.icon=null
					usr.PlayerCheck()
					return

		for(var/mob/players/Player2/M in world)
			if(button=="Gamepad2Face3"&&usr.gameScreen=="CSS"&&M.selected&&!M.selecting)
				for(var/mob/selectors/Player2/P1 in world)
					M.selected=0
					usr<<cancel
					activePlayers.Remove(M)
					M.UnPickCharacter()
					P1.icon_state="P2"

					for(var/mob/people/Player2/pp1 in world)
						pp1.icon_state="Idle"
			if(button=="Gamepad2Face2"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player2/P1 in world)
					M.selecting=1
					M.selected=1
					usr<<select

					flick("P2-select",P1)
					spawn(6)
						P1.icon_state="P2-selected"
					spawn(10)
						M.selecting=0
					for(var/obj/css/c in P1.hovering)
						M.character=c.character
						world<<c.clip
						activePlayers.Add(M)
						M.PickCharacter(M.character)
					for(var/mob/people/Player2/pp1 in world)
						flick("Power",pp1)
						spawn(1)
							usr<<punch
						spawn(3)
							pp1.icon_state="Show"
			if(button=="Gamepad2Left"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player2/P1 in world)
					usr<<menubutton
					if(P1.slot==1||P1.slot==6)
						P1.x+=32
						P1.slot+=4
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player2/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player2/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
					else
						P1.x-=8
						P1.slot--
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player2/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player2/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad2Right"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player2/P1 in world)
					usr<<menubutton
					if(P1.slot==5||P1.slot==10)
						P1.x-=32
						P1.slot-=4
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player2/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player2/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
					else
						P1.x+=8
						P1.slot++
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player2/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player2/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad2Up"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player2/P1 in world)
					usr<<menubutton
					if(P1.slot>=6&&P1.slot<=10)
						P1.y+=8
						P1.slot-=5
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player2/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player2/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return
			if(button=="Gamepad2Down"&&usr.gameScreen=="CSS"&&!M.selected&&M.active)
				for(var/mob/selectors/Player2/P1 in world)
					usr<<menubutton
					if(P1.slot>=1&&P1.slot<=6)
						P1.y-=8
						P1.slot+=5
						P1.hovering.Remove(P1.hovering)
						for(var/obj/css/c in P1.loc)
							P1.hovering.Add(c)
							for(var/mob/names/Player2/n2 in world)
								n2.icon_state=c.character
							for(var/mob/people/Player2/pp1 in world)
								pp1.icon=c.icon
								pp1.icon_state="Idle"
						return


		//PLAYER 1
		if(button=="GamepadStart" &&usr.gameScreen=="CSS")
			if(usr.active && usr.selected)
				if(usr.PlayerCheck())
					fade.Map(usr, 255, 16, 3)
					for(var/mob/M in activePlayers)
						if(M.playerNumber==1)
							M.loc=locate(36,28,1)
							M.bound_width=19
							M.bound_height=20
							M.bound_x=21
							M.bound_y=10
							M.leader=1
							spawn(60)
								M.LeaderScan()
							M.invisibility=0
							spawn(10)
								usr.P1_UI_LOAD()
						if(M.playerNumber==2)
							M.loc=locate(34,28,1)
							M.bound_width=19
							M.bound_height=20
							M.bound_x=21
							M.bound_y=10
							M.invisibility=0
							spawn(10)
								usr.P2_UI_LOAD()
						M.gameScreen="GAME"
					spawn(10)
						fade.Map(usr, 0, 16, 3)

			if(!usr.active)
				usr.active=1
				usr.playerNumber=1
				playerCount++
				var/mob/selectors/Player1/P1 = new
				P1.loc=locate(28,28,2)
				P1.slot=1
				for(var/obj/css/c in P1.loc)
					P1.hovering.Add(c)
					for(var/mob/names/Player1/n2 in world)
						n2.icon_state=c.character
					for(var/mob/people/Player1/pp1 in world)
						pp1.icon=c.icon
						pp1.icon_state="Idle"
				for(var/mob/portraits/Player1/P in world)
					P.icon_state="P1"
				usr.PlayerCheck()
				return

			if(usr.active && !usr.selected)
				for(var/mob/selectors/Player1/P1 in world)
					del P1
				usr.active=0
				playerCount--
				for(var/mob/portraits/Player1/P in world)
					P.icon_state="P1-lock"
				for(var/mob/people/Player1/pp1 in world)
					pp1.icon=null
				for(var/mob/names/Player1/n2 in world)
					n2.icon_state=null
				usr.PlayerCheck()
				return
		if(button=="GamepadFace3"&&usr.gameScreen=="CSS"&&usr.selected&&!usr.selecting)
			for(var/mob/selectors/Player1/P1 in world)
				usr.selected=0
				usr<<cancel
				activePlayers.Remove(usr)
				usr.UnPickCharacter()
				P1.icon_state="P1"

				for(var/mob/people/Player1/pp1 in world)
					pp1.icon_state="Idle"
		if(button=="GamepadFace2"&&usr.gameScreen=="CSS"&&!usr.selected&&usr.active)
			for(var/mob/selectors/Player1/P1 in world)
				usr.selecting=1
				usr.selected=1
				usr<<select

				flick("P1-select",P1)
				spawn(6)
					P1.icon_state="P1-selected"
				spawn(10)
					usr.selecting=0
				for(var/obj/css/c in P1.hovering)
					usr.character=c.character
					world<<c.clip
					activePlayers.Add(usr)
					usr.PickCharacter(usr.character)
				for(var/mob/people/Player1/pp1 in world)
					flick("Power",pp1)
					spawn(1)
						usr<<punch
					spawn(3)
						pp1.icon_state="Show"
		if(button=="GamepadLeft"&&usr.gameScreen=="CSS"&&!usr.selected&&usr.active)
			for(var/mob/selectors/Player1/P1 in world)
				usr<<menubutton
				if(P1.slot==1||P1.slot==6)
					P1.x+=32
					P1.slot+=4
					P1.hovering.Remove(P1.hovering)
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player1/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player1/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					return
				else
					P1.x-=8
					P1.slot--
					P1.hovering.Remove(P1.hovering)
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player1/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player1/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					return
		if(button=="GamepadRight"&&usr.gameScreen=="CSS"&&!usr.selected&&usr.active)
			for(var/mob/selectors/Player1/P1 in world)
				usr<<menubutton
				if(P1.slot==5||P1.slot==10)
					P1.x-=32
					P1.slot-=4
					P1.hovering.Remove(P1.hovering)
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player1/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player1/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					return
				else
					P1.x+=8
					P1.slot++
					P1.hovering.Remove(P1.hovering)
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player1/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player1/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					return
		if(button=="GamepadUp"&&usr.gameScreen=="CSS"&&!usr.selected&&usr.active)
			for(var/mob/selectors/Player1/P1 in world)
				usr<<menubutton
				if(P1.slot>=6&&P1.slot<=10)
					P1.y+=8
					P1.slot-=5
					P1.hovering.Remove(P1.hovering)
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player1/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player1/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					return
		if(button=="GamepadDown"&&usr.gameScreen=="CSS"&&!usr.selected&&usr.active)
			for(var/mob/selectors/Player1/P1 in world)
				usr<<menubutton

				if(P1.slot>=1&&P1.slot<=6)
					P1.y-=8
					P1.slot+=5
					P1.hovering.Remove(P1.hovering)
					for(var/obj/css/c in P1.loc)
						P1.hovering.Add(c)
						for(var/mob/names/Player1/n2 in world)
							n2.icon_state=c.character
						for(var/mob/people/Player1/pp1 in world)
							pp1.icon=c.icon
							pp1.icon_state="Idle"
					return