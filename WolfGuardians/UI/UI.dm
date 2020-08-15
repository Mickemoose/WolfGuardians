UI
	parent_type=/obj
	plane=10000

	appearance_flags = PIXEL_SCALE

	PLAYER1
		FRAME
			icon='UI/Frame.dmi'
			icon_state="frame"
			screen_loc="CENTER-22,NORTH-17"


		HEALTH_FRAME
			plane=FLOAT_PLANE
			icon='UI/Frame.dmi'
			icon_state="barframe"
			screen_loc="CENTER-22,NORTH-17:-48"

		FACE
			icon='UI/Faces.dmi'
			screen_loc="CENTER-22,NORTH-17"
		NAME
			icon='UI/Letters.dmi'
			screen_loc="CENTER-22,NORTH-17"
		LIVELABEL
			icon='UI/Letters.dmi'
			screen_loc="CENTER-21,NORTH-17"
		LIVES
			icon='UI/Letters.dmi'
	PLAYER2
		FRAME
			icon='UI/Frame.dmi'
			icon_state="frame"
			screen_loc="CENTER-22:420,NORTH-17"
		HEALTH_FRAME
			icon='UI/Frame.dmi'
			icon_state="barframe"
			screen_loc="CENTER-22:420,NORTH-17:-48"
		FACE
			icon='UI/Faces.dmi'
			screen_loc="CENTER-22:420,NORTH-17"
		NAME
			icon='UI/Letters.dmi'
			screen_loc="CENTER-22:420,NORTH-17"
		LIVELABEL
			icon='UI/Letters.dmi'
			screen_loc="CENTER-21:420,NORTH-17"
		LIVES
			icon='UI/Letters.dmi'
	PLAYER3
		FRAME
			icon='UI/Frame.dmi'
			icon_state="frame"
			screen_loc="CENTER-22:855,NORTH-17"
		HEALTH_FRAME
			icon='UI/Frame.dmi'
			icon_state="barframe"
			screen_loc="CENTER-22:855,NORTH-17:-48"
	PLAYER4
		FRAME
			icon='UI/Frame.dmi'
			icon_state="frame"
			screen_loc="CENTER-22:1280,NORTH-17"
		HEALTH_FRAME
			icon='UI/Frame.dmi'
			icon_state="barframe"
			screen_loc="CENTER-22:1280,NORTH-17:-48"

	New(client/c)
		c.screen+=src
		animate(src, transform = matrix()*1.5, time = 0)
proc
	P1_BARS_UPDATE()
		for(var/mob/M in world)
			if(M.client)
				M.p1special.setValue(M.special/100,2)
				M.bartest.setValue(M.health/100,2)
	P2_BARS_UPDATE()
		for(var/mob/M in world)
			if(M.client)
				for(var/mob/players/Player2/P2 in world)
					M.p2special.setValue(P2.special/100,2)
					M.p2health.setValue(P2.health/100,2)
mob/proc

	P1_UI_UPDATE()
		for(var/UI/PLAYER1/LIVES/P1 in src.client.screen)
			del(P1)
		var/num3=128
		for(var/i=1, i<=length(num2text(usr.lives)),i++)
			var/UI/PLAYER1/LIVES/N= new (src.client)
			N.screen_loc="CENTER-20:[num3],NORTH-19:64"
			animate(N, transform = matrix()*2, time = 0)
			N.icon_state="[copytext(num2text(usr.lives),i,i+1)]"
			num3+=13
		for(var/mob/M in world)
			if(M.client)
				if(M.isMorphed)
					for(var/UI/PLAYER1/FACE/F in usr.client.screen)
						F.icon_state=src.guardian
				else
					for(var/UI/PLAYER1/FACE/F in usr.client.screen)
						F.icon_state=src.character

	P2_UI_UPDATE()
		for(var/mob/players/Player2/P2 in world)
			for(var/UI/PLAYER2/LIVES/P1 in src.client.screen)
				del(P1)
			var/num3=128+420
			for(var/i=1, i<=length(num2text(P2.lives)),i++)
				var/UI/PLAYER2/LIVES/N= new (src.client)
				N.screen_loc="CENTER-20:[num3],NORTH-19:64"
				animate(N, transform = matrix()*2, time = 0)
				N.icon_state="[copytext(num2text(P2.lives),i,i+1)]"
				num3+=13
			if(P2.isMorphed)
				for(var/UI/PLAYER2/FACE/F in usr.client.screen)
					F.icon_state=P2.guardian
			else
				for(var/UI/PLAYER2/FACE/F in usr.client.screen)
					F.icon_state=P2.character
	P1_UI_LOAD()
		for(var/UI/PLAYER1/P1 in src.client.screen)
			del(P1)
		bartest = new/obj/maskbar/test()
		p1special = new/obj/maskbar/P1_Special()
		client.screen.Add(bartest,p1special)
		new/UI/PLAYER1/FRAME(src.client)
		var/UI/PLAYER1/FACE/F=new/UI/PLAYER1/FACE(src.client)
		var/num=13
		var/num2=13
		var/num3=128
		F.icon_state=src.character
		for(var/i=1, i<=length(usr.character),i++)
			var/UI/PLAYER1/NAME/N= new (src.client)
			N.screen_loc="CENTER-20:[num],NORTH-17:64"
			animate(N, transform = matrix()*2, time = 0)
			N.icon_state="[copytext(usr.character,i,i+1)]"
			num+=13
		for(var/i=1, i<=length("LIVES"),i++)
			var/UI/PLAYER1/LIVELABEL/N= new (src.client)
			N.screen_loc="CENTER-20:[num2],NORTH-19:64"
			animate(N, transform = matrix()*2, time = 0)
			N.icon_state="[copytext("LIVES",i,i+1)]"
			num2+=13
		for(var/i=1, i<=length(num2text(usr.lives)),i++)
			var/UI/PLAYER1/LIVES/N= new (src.client)
			N.screen_loc="CENTER-20:[num3],NORTH-19:64"
			animate(N, transform = matrix()*2, time = 0)
			N.icon_state="[copytext(num2text(usr.lives),i,i+1)]"
			num3+=13
	P2_UI_LOAD()
		for(var/mob/players/Player2/P2 in world)
			p2health = new/obj/maskbar/p2health()
			p2special = new/obj/maskbar/P2_Special()
			client.screen.Add(p2health,p2special)
			new/UI/PLAYER2/FRAME(src.client)
			var/UI/PLAYER2/FACE/F=new/UI/PLAYER2/FACE(src.client)
			var/num=13+420
			var/num2=13+420
			var/num3=128+420
			F.icon_state=P2.character
			for(var/i=1, i<=length(P2.character),i++)
				var/UI/PLAYER2/NAME/N= new (src.client)
				N.screen_loc="CENTER-20:[num],NORTH-17:64"
				animate(N, transform = matrix()*2, time = 0)
				N.icon_state="[copytext(P2.character,i,i+1)]"
				num+=13
			for(var/i=1, i<=length("LIVES"),i++)
				var/UI/PLAYER2/LIVELABEL/N= new (src.client)
				N.screen_loc="CENTER-20:[num2],NORTH-19:64"
				animate(N, transform = matrix()*2, time = 0)
				N.icon_state="[copytext("LIVES",i,i+1)]"
				num2+=13
			for(var/i=1, i<=length(num2text(P2.lives)),i++)
				var/UI/PLAYER2/LIVES/N= new (src.client)
				N.screen_loc="CENTER-20:[num3],NORTH-19:64"
				animate(N, transform = matrix()*2, time = 0)
				N.icon_state="[copytext(num2text(P2.lives),i,i+1)]"
				num3+=13
	P3_UI_LOAD()
		new/UI/PLAYER3/FRAME(src.client)
		new/UI/PLAYER3/HEALTH_FRAME(src.client)
	P4_UI_LOAD()
		new/UI/PLAYER4/FRAME(src.client)
		new/UI/PLAYER4/HEALTH_FRAME(src.client)



