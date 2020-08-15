/*
	These are simple defaults for your project.
 */
mob/proc/MapZoom()
	var/obj/map_zoom/Z = new() ; Z.appearance_flags = PLANE_MASTER | PIXEL_SCALE
	client.screen += Z
	animate(Z, transform = matrix()*4, time = 0)
	var/obj/map_zoom2/Z2 = new() ; Z2.appearance_flags = PLANE_MASTER | PIXEL_SCALE
	client.screen += Z2
	animate(Z2, transform = matrix()*4, time = 0)
	var/obj/map_zoom3/Z3 = new() ; Z3.appearance_flags = PLANE_MASTER | PIXEL_SCALE
	client.screen += Z3
	animate(Z3, transform = matrix()*4, time = 0)


obj/map_zoom
	appearance_flags = PLANE_MASTER || PIXEL_SCALE
	screen_loc = "1,1"
	plane = 0

obj/map_zoom2
	appearance_flags = PLANE_MASTER || PIXEL_SCALE
	screen_loc = "1,1"
	plane = 1

obj/map_zoom3
	appearance_flags = PLANE_MASTER || PIXEL_SCALE
	screen_loc = "1,1"
	plane = 3
client/var/iconsize = 2 //this var is what defines by how much we zoom in!


client

	//perspective = EDGE_PERSPECTIVE
	var
		fullscreen = 0	//Keep track of whether window is in fullscreen mode or not.
		map_fade/map_fade_loaded
	New() //When a new client arrives (a new user logs in)...
		..() //Perform the default new client proc
	//	cloudy_clients += src
		ToggleFullscreen() //Then toggle fullscreen to TRUE

	verb //Verbs can be accessed by the macros (using key presses), so we need to define verbs (not procs) for our key presses.
		ToggleFullscreen()
			fullscreen = !fullscreen //Toggle the fullscreen variable
			if(fullscreen) //If fullscreen == 1 (TRUE)
				winset(src, "default", "is-maximized=false;can-resize=false;titlebar=false;menu=") //Reset to not maximized and turn off titlebar.
				winset(src, "default", "is-maximized=true") //Now set to maximized. We have to do this separately, so that the taskbar is appropriately covered.
				winset(src, "default.map1", "zoom=1")
			else //If fullscreen == 0 (FALSE)
				winset(src, "default", "is-maximized=false;can-resize=true;titlebar=true;menu=menu") //Set window to normal size.
				winset(src, "default.map1", "zoom=1")

world
	map_format = SIDE_MAP
	fps = 40	// 25 frames per second
	icon_size = 32	// 32x32 icon size by default
	view = 30		// show up to 6 tiles outward from center (13x13 view)
	tick_lag = 0.25 // 0.25 is equal to 40fps

// Make objects move 8 pixels per tick when walking

mob
	step_size = 2

obj
	step_size = 8

mob
	var
		debug=0
		lastdir=null
		obj/maskbar/bartest
		obj/maskbar/p1special
		obj/maskbar/p2special
		obj/maskbar/p2health
	Login()
		MapZoom()
		if(debug)
			for(var/mob/players/Player2/P2 in world)
				P2.loc=locate(44,30,1)
				P2.character="DEREK"
				P2.guardian="RED"
				P2.gicon = file('CHARACTERS/Red.dmi')
				P2.icon='CHARACTERS/Derek.dmi'
				P2.icon_state="Idle"
				P2.bound_width=19
				P2.bound_height=20
				P2.bound_x=21
				P2.dir=EAST
				P2.lastdir=EAST
			src.loc=locate(42,30,1)
			src.character="DEREK"
			src.guardian="RED"
			src.gicon = file('CHARACTERS/Red.dmi')
			src.client.eye=src
			icon='CHARACTERS/Derek.dmi'
			icon_state="Idle"
			bound_width=19
			bound_height=20
			bound_x=21
			src.dir=EAST
			src.lastdir=EAST
			activePlayers.Add(src)
			usr.P1_UI_LOAD()
			usr.P2_UI_LOAD()
			usr.P3_UI_LOAD()
			usr.P4_UI_LOAD()
			P1_BARS_UPDATE()
			P2_BARS_UPDATE()
		else
			src.loc=locate(44,39,2)
			src.gameScreen="CSS"
			src<<css
			spawn(1)
				src<<csstitle
		//	CSS_Start()
		..()

	//	if(dir!=EAST||dir!=WEST)
	//		dir=lastdir


atom/movable
	var global/ActiveOutline = filter(type = "outline", color = "red", size = 2)
	var global/WhiteOutline = filter(type = "outline", color = "white", size = 1)

