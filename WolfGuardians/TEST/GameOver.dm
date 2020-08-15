proc
	GameOver()
		fade.Map(usr, 150, 16, 6)
		spawn(6)
			var/obj/messagebox/B=new/obj/messagebox(usr.client)
			B.icon_state="gameover"
			spawn(20)
				fade.Map(usr, 255, 16, 3)
				del B
				spawn(5)
					usr.CSS_Start()
					fade.Map(usr, 0, 16, 3)