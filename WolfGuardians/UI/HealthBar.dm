

obj/maskbar/test
//	appearance_flags = PIXEL_SCALE
	icon = 'UI/Health.dmi'
	screen_loc="CENTER-23:-8,NORTH-17:-64"
	width = 184
	height = 16
	orientation = EAST
	New()
		appearance_flags += PIXEL_SCALE
		animate(src, transform = matrix()*1.5, time = 0)
		..()

obj/maskbar/p2health
//	appearance_flags = PIXEL_SCALE
	icon = 'UI/Health.dmi'
	screen_loc="CENTER-10:-4,NORTH-17:-64"
	width = 184
	height = 16
	orientation = EAST
	New()
		appearance_flags += PIXEL_SCALE
		animate(src, transform = matrix()*1.5, time = 0)
		..()