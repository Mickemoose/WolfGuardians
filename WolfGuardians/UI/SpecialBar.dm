obj/maskbar
	plane=2
	appearance_flags = KEEP_TOGETHER || PIXEL_SCALE
	mouse_opacity = 0
	var
		obj/foreground
		obj/background
		obj/fill
		obj/mask

		width = 0
		height = 0
		orientation = EAST

	New()
		Build()
		vis_contents.Add(mask,foreground)
		..()

	Del()
		//break relationships
		vis_contents.Remove(mask,foreground)
		background.vis_contents -= fill
		mask.vis_contents -= background
		..()

	proc
		Build()
			//create constituent objects
			foreground = new/obj/maskpart/fg(null,icon)
			background = new/obj/maskpart/bg(null,icon)
			fill = new/obj/maskpart/fill(null,icon)
			mask = new/obj/maskpart/mask(null,icon)

			//arrange constituent objects
			background.vis_contents += fill
			mask.vis_contents += background

		setValue(ratio=1.0,duration=0)
			//constrain the ratio between 0 and 1
			ratio = min(max(ratio,0),1)

			//apply orientation factors for fill bar offsets
			var/fx = 0, fy = 0
			switch(orientation)
				if(EAST)
					fx = -1
				if(WEST)
					fx = 1
				if(SOUTH)
					fy = 1
				if(NORTH)
					fy = -1

			//calculate the offset of the fill bar.
			var/invratio = 1-ratio
			var/epx = width * invratio * fx
			var/epy = height * invratio * fy

			//apply the offset to the fill bar
			if(duration)
				//if a time value has been supplied, animate the transition from the current position
				animate(fill,pixel_w=epx,pixel_z=epy,time=duration)
			else
				//if a time value has not been supplied, instantly set to the new position
				fill.pixel_w = epx
				fill.pixel_z = epy

obj/maskpart
	//layer = FLOAT_LAYER
	plane = FLOAT_PLANE

	bg
		icon_state = "bg"
		appearance_flags = KEEP_TOGETHER | PIXEL_SCALE
		blend_mode = BLEND_MULTIPLY
	fg
		icon_state = "fg"
		appearance_flags = PIXEL_SCALE
	fill
		icon_state = "fill"
		appearance_flags = PIXEL_SCALE
	mask
		icon_state = "mask"
		appearance_flags = PIXEL_SCALE

	New(loc,icon)
		src.icon = icon
		..()

obj/maskbar/P1_Special
//	appearance_flags = PIXEL_SCALE
	icon = 'UI/Special.dmi'
	screen_loc="CENTER-20:-20,NORTH-17:-78"
	width = 74
	height = 6
	orientation = EAST
	New()
		appearance_flags += PIXEL_SCALE
		animate(src, transform = matrix()*2, time = 0)
		..()
obj/maskbar/P2_Special
//	appearance_flags = PIXEL_SCALE
	icon = 'UI/Special.dmi'
	screen_loc="CENTER-7:-16,NORTH-17:-78"
	width = 74
	height = 6
	orientation = EAST
	New()
		appearance_flags += PIXEL_SCALE
		animate(src, transform = matrix()*2, time = 0)
		..()