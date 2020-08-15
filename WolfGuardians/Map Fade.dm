client/New()
	..()

//	src.screen += new/map_fade
//	src.screen += new/map_fade_green
	//fade.Map(src,0,5,color="black")
	//fade.Map(src,0,0.1,color="green")

//	for(var/map_fade/m in src.screen)
	//	animate(m, alpha=0, time=5)
var/fade/fade = new()
map_fade
	parent_type = /atom/movable

	icon = 'fade_gradient.dmi'
	icon_state = "0"

	screen_loc = "NORTHWEST to SOUTHEAST"

	// Defaults to 255, but this can be altered with the fade.MapLayer() proc.
	plane=2



fade

	/*
	MAP ALPHA FADE
	Description: This causes the map_fade datum, which is stretched across the entire
		map window to fade from one level of alpha transparency to another.
	Exceptions: Will not work if no client/mob or alpha level is specified.
	Variables:
		- client/C: This is the client or mob (with client) being affected.
		- alpha: The level of alpha transparency that you want displayed.
		- increments: This is the number of increments between the map's original alpha
			transparency the new alpha transparency. Each increment is an amount of time
			equal to the world's tick_lag.
	*/
	proc/Map(client/C, alpha, increments = 10, time = 8)


		// Since alpha can be zero, we need to check if its boolean false
		// but also make sure that its non-zero at the same time.
		if(!alpha)
			if(alpha != 0)
				return

		if(!C || increments < 1)
			return

		// If the "client" is actually a mob, assign the mob's client to C.
		if(ismob(C))
			var/mob/M = C
			if(!M.client)
				return
			C = M.client

		// Find the client's map_fade object in the screen list.
		if(!C.map_fade_loaded)
			C.map_fade_loaded = new/map_fade
			C.screen += C.map_fade_loaded

		// If the map's alpha is already that shade, cancel.
		if(C.map_fade_loaded.icon_state == "[alpha]")
			return

		// If there are more increments than there is time to have at
		// lest one tick per increment, then limit the number of increments
		// to the amount of time available.
		increments = min(increments, time)

		// Calculate the amount of change we need with each increment.
		var/current_alpha = text2num(C.map_fade_loaded.icon_state)
		var/inc_amount = (alpha - current_alpha) / increments
		var/inc_time = time / increments

		for(var/inc = 0, inc < increments, inc++)


			// This is a check to see if the map_fade is changing outside
			// of this function. If the map fade is changing through some
			// other function, then we will cut this function short.
			if(C.map_fade_loaded.icon_state != "[round(current_alpha)]")
				return // end prematurely

			current_alpha += inc_amount
			C.map_fade_loaded.icon_state = "[round(current_alpha)]"
			sleep(inc_time * world.tick_lag)

		return 1



	/*
	MAP ALPHA SET
	Description: Instantly sets the map's alpha transparency level.
	Exceptions: Will not work if no client/mob or alpha level is specified.
	Variables:
		- client/C: This is the client or mob (with client) being affected.
		- alpha: The level of alpha transparency that you want displayed.
	*/
	proc/MapSet(client/C, alpha)

		// Since alpha can be zero, we need to check if its boolean false
		// but also make sure that its non-zero at the same time.
		if(!alpha)
			if(alpha != 0)
				return

		if(!C)
			return

		// If the "client" is actually a mob, assign the mob's client to C.
		if(ismob(C))
			var/mob/M = C
			if(!M.client)
				return
			C = M.client

		// Find the client's map_fade object in the screen list.
		var/map_fade/map_fade
		for(var/map_fade/M in C.screen)
			map_fade = M
			break

		// If the client doesn't have a map_fade object, cancel!
		if(!map_fade)
			return

		// If the map's alpha is already that shade, cancel.
		if(map_fade.icon_state == "[alpha]")
			return

		// Set the map fade to the desired alpha.
		map_fade.icon_state = "[round(alpha)]"

		return 1



	/*
	MAP ALPHA LAYER
	Description: Changes the layer that the map_fade object is displayed on.
		Use this if you need to change the layer because it interferes with your
		current HUD or has other layering issues.
	Exceptions: Will not work if no client/mob or new layer is specified.
	Variables:
		- client/C: This is the client or mob (with client) being affected.
		- new_layer: The new layer to assign the map_fade object to.
	*/
	proc/MapLayer(client/C, new_layer)
		if(!C)
			return

		// If the "client" is actually a mob, assign the mob's client to C.
		if(ismob(C))
			var/mob/M = C
			if(!M.client)
				return
			C = M.client

		var/found = 0
		for(var/map_fade/M in C.screen)
			found = 1
			M.layer = new_layer
			break

		return found