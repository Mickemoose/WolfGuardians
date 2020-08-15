turf
	plane=0
	layer=1
	TEST
		icon='TEST/turf.dmi'
	//	grass
	//		icon_state="grass"
		roadn
			icon_state="roadn"
		sky
			icon_state="sky"
			density=1
		road
			icon='road.dmi'
		DENSE
			icon_state="sky"
			density=1
			invisibility=1
			Enter(mob/m)
				return 0