mob
	Enemy
		Goober
			icon='CHARACTERS/Goober.dmi'
			icon_state="Idle"
			bound_width=18
			bound_height=20
			bound_x=21
			bound_y=10
			health=50
			dir=WEST
			lastdir=WEST
			density=0

		/*	VelocityEnabled()
				if(isThrown)
					HitScan(5,xoffset=0,extrawidth=5,extra_height=0,knockback=1,stunAmount=10,damage=12)
				..()

			Crossed(var/mob/E)
				if(isThrown)
					if(istype(E,/mob/Enemy))
						src.HitScan(5,xoffset=0,extrawidth=5,extra_height=0,knockback=1,stunAmount=10,damage=12) */
		var
			list
				targets=list()
			AI_ON=0
			target
			state="Idle"
			huntCooldown=0

		New()
			AI()
		//	AILoop()
		proc
			AI()
				while(!src.isDead)
					AI_ON=1
					for(var/mob/M in oview(5))
						if(bounds_dist(src,M)<=2 && !istype(M,/mob/Enemy) && !M.isDead)
							src.force_dir=src.dir
							if(!attacking &&!isThrown &&!isStunned)
								src.Combo()
							else
								break
						else
							if(!attacking &&!isThrown&&!isStunned)
								walk_to(src, M,-16, 0.75)
								break
							else
								break
					sleep(5)

			AILoop()
				spawn(30)
					if(AI_ON==0)
						AI()

			Scan()
				state="Scanning"
				world.log << "SCANNING"
				targets.Add(activePlayers)
				world.log << " ADDED TO TARGETS"
				var/mob/target=pick(targets)
				world.log << "[target] PICKED"
				spawn(12)
					Hunt(target)


			Hunt(var/mob/target)
				state="Hunting"
				if( target in targets )
					if(!huntCooldown)
						walk_to(src, target,0,0, 0.75)
						Check()
						spawn(6)
							Hunt(target)


			Check()
				if(dir==EAST)
					for(var/mob/target in bounds(src, 6, 0, 0, 0))
						if(!target.isDead && target!=src && target.icon_state!="down")
							spawn(10)
								if(prob(50))
									Combo(distance=2,damage=2)
									spawn(100)
										state="Idle"
										huntCooldown=1
										spawn(10)
											huntCooldown=0
										AI()
								else if(prob(30))
									Combo(distance=2,damage=2)
									spawn(5)
										Combo(distance=2,damage=2)
										spawn(100)
											state="Idle"
											huntCooldown=1
											spawn(10)
												huntCooldown=0
											AI()
								else if(prob(20))
									Combo(distance=2,damage=2)
									spawn(5)
										Combo(distance=2,damage=2)
										spawn(5)
											Combo(distance=5,stunAmount=8,knockback=1,damage=3)
											spawn(100)
												state="Idle"
												huntCooldown=1
												spawn(10)
													huntCooldown=0
												AI()
				if(dir==WEST)
					for(var/mob/target in bounds(src, -6, 0, 0, 0))
						if(!target.isDead && target!=src && target.icon_state!="down")
							spawn(10)
								if(prob(50))
									Combo(distance=2,damage=2)
									spawn(100)
										state="Idle"
										huntCooldown=1
										spawn(10)
											huntCooldown=0
										AI()
								else if(prob(30))
									Combo(distance=2,damage=2)
									spawn(5)
										Combo(3)
										spawn(100)
											state="Idle"
											huntCooldown=1
											spawn(10)
												huntCooldown=0
											AI()
								else if(prob(20))
									Combo(distance=2,damage=2)
									spawn(5)
										Combo(distance=2,damage=2)
										spawn(5)
											Combo(distance=5,stunAmount=8,knockback=1,damage=3)
											spawn(100)
												state="Idle"
												huntCooldown=1
												spawn(10)
													huntCooldown=0
												AI()


/*

AI State Machine

- Idle
- See targets, Pick target
- Go to target
- Fuck up target
- smile :)




*/