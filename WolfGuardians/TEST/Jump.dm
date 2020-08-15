mob
	proc
		Jump()
			if(canJump)
				attacking=1
				spawn(1)
					attacking=0
				canJump=0
				isJumping=1
				flick("Jump",src)
				spawn(10)
					isJumping=0
				spawn(13)
					canJump=1


		Fall()
			SetVelocity(0,-1)
			spawn(2)
				SetVelocity(0,-4)
				spawn(3)
					SetVelocity(Vector2.Zero)
					spawn(2)
						canJump=1
