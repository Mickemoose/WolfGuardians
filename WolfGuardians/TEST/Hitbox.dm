hitbox
	parent_type=/obj
	icon='TEST/hitbox.dmi'
	bound_width=16
	bound_height=16
	plane=10
	var
		owner=null
		list
			targets=list()
	Crossed(mob/Enemy/E)
		if(src.owner!=E)
			animate(E,color=rgb(255,0,0),time=3)
			spawn(3)
				animate(E,color=rgb(255,255,255),time=3)
	New(vector2/position, z, bound_width/width, bound_height/height)
		if(position && z)
			SetCenterTo(position, z)

mob
	proc
		Hitbox(frames=10,px=0,py=0,width=16,height=16)
			var/hitbox/H = new /hitbox(usr,usr.z,width,height)
			H.owner=usr
			spawn(frames)
				del H
		//bounds(Ref, x_offset, y_offset, extra_width=0, extra_height=0)
		HitScan(distance,xoffset=16,yoffset=0,extrawidth=0,extra_height=-16,stunAmount=3,knockback=0,damage=0)

			if(dir==EAST)
				for(var/obj/containers/C in bounds(src, xoffset, yoffset, extrawidth, -8)) if(!C.broken)
					C.BreakOpen()
				for(var/mob/E in bounds(src, xoffset, yoffset, extrawidth, extra_height)) if(!E.isDead && E!=src)

					if(istype(E,/mob/Enemy))
						E.health-=damage
					else
						E.DealDamage(damage)
					if(E.health<=0)
						knockback=1
						stunAmount=10
					view()<<hit
					E.isStunned=1
					if(src.isMorphed)
						src.GainPower(2)
					else
						src.GainPower(4)
					E.icon_state="hit"
					E.HitStun(EAST,distance,knockback)
					animate(E,color=rgb(255,0,0),time=3)
					spawn(stunAmount)
						animate(E,color=rgb(255,255,255),time=3)
						E.icon_state="Idle"
						walk(E,0)
						E.isStunned=0
			if(src.dir==WEST)
				for(var/obj/containers/C in bounds(src, -xoffset, yoffset, extrawidth, -8)) if(!C.broken)
					C.BreakOpen()
				for(var/mob/E in bounds(src, -xoffset, yoffset, extrawidth, extra_height)) if(!E.isDead && E!=src)
					if(istype(E,/mob/Enemy))
						E.health-=damage
					else
						E.DealDamage(damage)
					if(E.health<=0)
						knockback=1
						stunAmount=10
					view()<<hit
					E.isStunned=1
					if(src.isMorphed)
						src.GainPower(2)
					else
						src.GainPower(4)
					E.icon_state="hit"
					E.HitStun(WEST,distance,knockback)
					animate(E,color=rgb(255,0,0),time=3)
					spawn(stunAmount)
						animate(E,color=rgb(255,255,255),time=3)
						E.icon_state="Idle"
						walk(E,0)
						E.isStunned=0

		HitStun(direction,distance,knockback=0,thrown=0)
			if(!knockback)
				if(direction==EAST)
					src.force_dir = src.lastdir
					walk(src,EAST,0,distance)
					spawn(1)
						src.force_dir = src.lastdir
						walk(src,0)
				if(direction==WEST)
					src.force_dir = src.lastdir
					walk(src,WEST,0,distance)
					spawn(1)
						src.force_dir = src.lastdir
						walk(src,0)
			else if(thrown)
				flick("knockback",src)
				density=0
				if(direction==EAST)
				//	SetVelocity(18, 0)
					src.force_dir = WEST
					walk(src,EAST,0,6)
					spawn(6)
					//	SetVelocity(14, 0)
						src.force_dir = WEST
						walk(src,EAST,0,4)
						spawn(3)
						//	SetVelocity(4, 0)
							src.force_dir = WEST
							walk(src,EAST,0,2)
							spawn(2)
								src.force_dir = WEST
								walk(src,0)
				if(direction==WEST)
				//	SetVelocity(18, 0)
					src.force_dir = EAST
					walk(src,WEST,0,6)
					spawn(6)
					//	SetVelocity(14, 0)
						src.force_dir = EAST
						walk(src,WEST,0,4)
						spawn(3)
						//	SetVelocity(4, 0)
							src.force_dir = EAST
							walk(src,WEST,0,2)
							spawn(2)
								src.force_dir = EAST
								walk(src,0)

				spawn(16)
					src.force_dir = src.lastdir
					walk(src,0)
					density=1
					icon_state="down"
					spawn(4)
						DeathCheck()
			else
				flick("knockback",src)
				isThrown=1
				density=0
				if(direction==EAST)
				//	SetVelocity(18, 0)
					src.force_dir = src.lastdir
					walk(src,EAST,0,2.5)
					spawn(2)
					//	SetVelocity(14, 0)
						src.force_dir = src.lastdir
						walk(src,EAST,0,3)
						spawn(1)
						//	SetVelocity(4, 0)
							src.force_dir = src.lastdir
							walk(src,EAST,0,2)
							spawn(1)
								walk(src,0)
				if(direction==WEST)
				//	SetVelocity(18, 0)
					src.force_dir = src.lastdir
					walk(src,WEST,0,2.5)
					spawn(2)
					//	SetVelocity(14, 0)
						src.force_dir = src.lastdir
						walk(src,WEST,0,3)
						spawn(1)
						//	SetVelocity(4, 0)
							src.force_dir = src.lastdir
							walk(src,WEST,0,2)
							spawn(1)
								walk(src,0)

				spawn(16)
					density=1
					icon_state="down"
					spawn(4)
						DeathCheck()
		DeathCheck()
			if(health<=0)
				isDead=1
				isThrown=0
				icon_state="down"
				Death()
			else
				flick("getup",src)
				spawn(1)
					isThrown=0
					icon_state="Idle"

		RespawnCheck()
			if(lives > 0)
				lives--
				isDead=0
				P1_UI_UPDATE()
				P2_UI_UPDATE()
				src.icon_state="Idle"
				src.isMorphed=0
				src.UsePower(75)
				src.HealDamage(100)
				src.filters -= WhiteOutline
				animate(src, alpha = 255, time = 0)
				if(src.character=="DEREK")
					src.icon='CHARACTERS/Derek.dmi'
				return
			else
				activePlayers.Remove(src)
				if(activePlayers.len<=0)
					GameOver()
				else
					return
		Death()
			if(deadTimer<=7)
				spawn(1.5)
					deadTimer--
					if(deadFlash==0)
						deadFlash=1
						animate(src, alpha = 0, time = 0)
					else
						deadFlash=0
						animate(src, alpha = 255, time = 0)
					if(deadTimer==0)
						if(istype(src,/mob/Enemy))
							del src
						else
							animate(src, alpha = 0, time = 0)
							RespawnCheck()
						return
					Death()
			else
				spawn(3)
					deadTimer--
					if(deadFlash==0)
						deadFlash=1
						animate(src, alpha = 0, time = 0)
					else
						deadFlash=0
						animate(src, alpha = 255, time = 0)
					if(deadTimer==0)
						del src
						return
					Death()