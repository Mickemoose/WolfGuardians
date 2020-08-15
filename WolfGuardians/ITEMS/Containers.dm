obj
	containers
		plane=1
		icon='ITEMS/Containers.dmi'
		density=1
		var
			broken=0
			list/
				possibleItems = list("pizza","icecream","sushi","shrimp","donut")
		Cross(mob/M)
			if(!broken)
				return 0
			else
				return 1
		Barrel
			icon_state="barrel"
			bound_width=20
			bound_height=20
			BreakOpen()
				icon_state="barrel-broken"
				..()
		proc
			BreakOpen()
				var/F=pick(possibleItems)
				var/obj/food/O = text2path("/obj/food/[F]")
				new O(src.loc)
				usr<<bbreak
				broken=1
				density=0
				SetVelocity(sqrt(1/2), sqrt(1/2))
				animate(src, alpha = 0, time = 1)
				spawn(1)
					animate(src, alpha = 255, time = 1)
					spawn(1)
						animate(src, alpha = 0, time = 1)
						spawn(1)
							animate(src, alpha = 255, time = 1)
							spawn(1)
								animate(src, alpha = 0, time = 1)
								spawn(1)
									animate(src, alpha = 255, time = 1)
									spawn(1)
										animate(src, alpha = 0, time = 1)
										spawn(1)
											del src