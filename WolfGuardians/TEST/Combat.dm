button_tracker/echo
	Pressed(button)
		if(!usr.attacking||!usr.isThrown)
			..()
			if(button=="GamepadUp" && !usr.attacking &&usr.gameScreen!="CSS")
				usr.force_dir = usr.lastdir
			if(button=="GamepadDown" && !usr.attacking &&usr.gameScreen!="CSS")
				usr.force_dir = usr.lastdir
			if(button=="GamepadFace1"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isJumping)
				usr.Activate()
			if(button=="GamepadFace2"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isJumping)
				usr.Grab()
				usr.Activate()
			if(button=="GamepadFace3"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isJumping)
				usr.Combo()
			if(button=="GamepadLeft"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isThrown)
				usr.force_dir = WEST
				usr.dir=WEST
				usr.lastdir=WEST
			if(button=="GamepadRight"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isThrown)
				usr.force_dir = EAST
				usr.dir=EAST
				usr.lastdir=EAST
			if(button=="GamepadUpLeft"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isThrown)
				usr.force_dir = WEST
				usr.dir=WEST
				usr.lastdir=WEST
			if(button=="GamepadUpRight"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isThrown)
				usr.force_dir = EAST
				usr.dir=EAST
				usr.lastdir=EAST
			if(button=="GamepadDownLeft"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isThrown)
				usr.force_dir = WEST
				usr.dir=WEST
				usr.lastdir=WEST
			if(button=="GamepadDownRight"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isThrown)
				usr.force_dir = EAST
				usr.dir=EAST
				usr.lastdir=EAST
			if(button=="GamepadFace4"&&!usr.attacking&&usr.gameScreen!="CSS"&&!usr.isJumping)
				usr.Morph()
			if(button=="North"||button=="GamepadUp")
				return
		else







mob
	proc
		UsePower(amount)
			src.special-=amount
			if(src.special<=0)
				src.special=0
			for(var/mob/M in world)
				if(M.client)
					M.p1special.setValue(M.special/100,2)
					for(var/mob/players/Player2/P2 in world)
						M.p2special.setValue(P2.special/100,2)
			P1_BARS_UPDATE()
			P2_BARS_UPDATE()
		GainPower(amount)
			src.special+=amount
			if(src.special>=100)
				src.special=100
			for(var/mob/M in world)
				if(M.client)
					M.p1special.setValue(M.special/100,2)
					for(var/mob/players/Player2/P2 in world)
						M.p2special.setValue(P2.special/100,2)
			P1_BARS_UPDATE()
			P2_BARS_UPDATE()
		DealDamage(amount)
			src.health-=amount
			if(src.health<=0)
				src.health=0
			for(var/mob/M in world)
				if(M.client)
					M.bartest.setValue(M.health/100,2)
					for(var/mob/players/Player2/P2 in world)
						M.p2health.setValue(P2.health/100,2)
			P1_BARS_UPDATE()
			P2_BARS_UPDATE()
		HealDamage(amount)
			src.health+=amount
			if(src.health>=100)
				src.health=100
			for(var/mob/M in world)
				if(M.client)
					M.bartest.setValue(M.health/100,2)
					for(var/mob/players/Player2/P2 in world)
						M.p2health.setValue(P2.health/100,2)
			P1_BARS_UPDATE()
			P2_BARS_UPDATE()

		ComboTimer()
			if(attacking==0)
				spawn(1)
					comboTimer--
					if(comboTimer==0)
						comboCount=0
						comboTimer=3
						return
					ComboTimer()
			else
				spawn(1)
					ComboTimer()
		Activate()
			for(var/obj/food/E in bounds(src, 0, 0, 0, 0))
				flick("Pick",src)
				E.loc=locate(1,1,1)
				view()<<munch
				animate(src,color=rgb(0,255,0),time=3)
				src.HealDamage(E.health)
				src.attacking=1
				src.attackCooldown=1
				spawn(1.5)
					animate(src,color=rgb(255,255,255),time=3)
					src.attacking=0
					src.attackCooldown=0
					del(E)

				break
		Grab()

			if(src.dir==EAST)
				for(var/mob/E in bounds(src, 6, 0, 0, -12)) if(!E.isDead && E.icon_state=="Idle" && E!=src)
					src.attackCooldown=1
					src.icon_state="Grab"
					E.isStunned=1
					E.icon_state="hit"
					spawn(5)
						flick("Throw",src)
						spawn(1)
							src.GainPower(5)
							src<<punch
						E.isThrown=1
						if(istype(E,/mob/Enemy))
							E.health-=12
						else
							E.DealDamage(12)
						E.dir=EAST
						E.HitStun(WEST,0,knockback=1,thrown=1)
						spawn(4)
							src.SetVelocity(Vector2.Zero)
							src.icon_state="Idle"
							src.attackCooldown=0
					break
			if(src.dir==WEST)
				for(var/mob/E in bounds(src, -6, 0, 0, -12)) if(!E.isDead && E.icon_state=="Idle" && E!=src)
					world.log<<"[usr] [src] [E]"
					src.attackCooldown=1
					src.icon_state="Grab"
					E.isStunned=1
					E.icon_state="hit"
					spawn(5)
						flick("Throw",src)
						spawn(1)
							src.GainPower(5)
							src<<punch
						E.isThrown=1
						if(istype(E,/mob/Enemy))
							E.health-=12
						else
							E.DealDamage(12)
						E.dir=WEST
						E.HitStun(EAST,0,knockback=1,thrown=1)
						spawn(4)
							src.SetVelocity(Vector2.Zero)
							src.icon_state="Idle"
							src.attackCooldown=0
					break
		Combo()
			if(comboCount==0)
				if(!src.attackCooldown)
					src.attacking=1
					src.attackCooldown=1
					flick("Punch1",src)
					spawn(2)
						view()<<punch
						src.HitScan(distance=0.5,damage=2)
						spawn(4)
							src.attackCooldown=0
							src.attacking=0
							comboCount=1
							ComboTimer()
			if(comboCount==1)
				if(!src.attackCooldown)
					src.attacking=1
					src.attackCooldown=1
					flick("Punch2",src)
					spawn(2.5)
						view()<<punch
						src.HitScan(distance=0.5,damage=3)
						spawn(3)
							src.attackCooldown=0
							src.attacking=0
							//comboTimer=3
							comboCount=2
			if(comboCount==2)
				if(!src.attackCooldown)
					src.attacking=1
					src.attackCooldown=1
					flick("Punch3",src)
					spawn(2)
						view()<<punch
						src.HitScan(distance=2,stunAmount=8,knockback=1,damage=5)
						spawn(5)
							src.attackCooldown=0
							src.attacking=0
							comboCount=0
