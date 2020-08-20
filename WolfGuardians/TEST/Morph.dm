mob
	proc
		Morph()
			if(special==100&&isMorphed==0&&!attacking)
				UsePower(75)
				isMorphed=1
				plane=3
				for(var/mob/Enemy/E in world)
					E.isStunned=1
				for(var/mob/M in world)
					M.attacking=1
					M.attackCooldown=1
				flick("Power",src)
				spawn(1)
					view()<<punch
				spawn(3)
					src.icon_state="Show"
					fade.Map(usr, 150, 16, 6)
					spawn(6)
						var/obj/messagebox/B=new/obj/messagebox(usr.client)
						B.icon_state=src.guardian
						spawn(15)
							del(B)
							flick("Morph",src)
							view()<<morph
							spawn(15)
								src.icon=src.gicon
								filters += WhiteOutline
								for(var/mob/M in world)
									if(M.client)
										for(var/UI/PLAYER1/FACE/F in usr.client.screen)
											F.icon_state=src.guardian
								for(var/mob/players/Player2/P2 in world)
									if(P2.isMorphed)
										for(var/UI/PLAYER2/FACE/F in usr.client.screen)
											F.icon_state=P2.guardian
								src.icon_state="Idle"
								src.attacking=0
								src.attackCooldown=0
								src.damage=10
								fade.Map(usr, 0, 16, 6)
								spawn(6)
									src.plane=1
									for(var/mob/Enemy/E in world)
										E.isStunned=0
									for(var/mob/M in world)
										M.attacking=0
										M.attackCooldown=0

			else
				return

obj
	messagebox
		icon='messagebox.dmi'
		plane=4
		appearance_flags = PIXEL_SCALE
		screen_loc="CENTER:-110,CENTER"
		New(client/c)
			c.screen+=src
			animate(src, transform = matrix()*4, time = 0)
