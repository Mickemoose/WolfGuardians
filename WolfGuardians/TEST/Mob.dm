/* Sets up the player for custom movement controls.
*/

/* Gives players a move speed variable.
	This is used by most (but not all) control schemes.
*/

mob
	var
		// How many pixels to move per decisecond
		move_speed = 4
		list
			hitboxes=list()


client
	New()
		macros = new/button_tracker/echo
		return ..()
	Move()

		..()
/* An updte loop specific to players that calls PlayerUpdate every tick for players that are logged in.
*/

mob
	var
		global/update_loop/PlayerLoop = new(null, "PlayerUpdate")

	Login()
		..()
		PlayerLoop += src

	Logout()
		PlayerLoop -= src
		..()

	proc
		PlayerUpdate()
			if(src.attackCooldown)
				return
			else
				..()



/* Enables velocity for movable atoms.
	Velocity is a vector2 that the movable moves by every decisecond.
	The movement happens every tick.
*/
var update_loop/VelocityLoop = new(0, "ApplyVelocity")

atom/movable
	var
		tmp
			has_velocity = FALSE
			slide_velocity = FALSE
			vector2/velocity

	New()
		..()
		if(velocity)
			var v = velocity
			velocity = null
			SetVelocity(v)

	proc
		/* Returns the current velocity.
		*/
		Velocity()
			return velocity || Vector2.Zero

		/* Sets the current velocity.
			Velocity looping is enabled if velocity is large enough, and disabled otherwise.
		*/
		SetVelocity(vector2/new_velocity)
			if(velocity ~= new_velocity) return
			velocity = new_velocity
			if(new_velocity ~! Vector2.Zero)
				if(!has_velocity)
					has_velocity = TRUE
					VelocityLoop += src
					VelocityEnabled()
			else
				if(has_velocity)
					has_velocity = FALSE
					VelocityLoop -= src
					VelocityDisabled()

		VelocityEnabled()

		VelocityDisabled()

		/* Accelerate by the given vector over a single tick.
			Simply adds the acceleration to velocity.
			Acceleration is scaled by the tick rate.
		*/
		Accelerate(vector2/acceleration)
			SetVelocity(Velocity() + acceleration * VelocityLoop.tick_lag)

		/* Move by velocity.
			Move only if speed is at least 1 pixel per decisecond.
			Makes it easier to come to a complete stop.
		*/
		ApplyVelocity()

			var
				vector2/motion = velocity * VelocityLoop.tick_lag
				moved
			if(slide_velocity)
				moved = PixelSlide(motion)
			else
				moved = PixelMove(motion)
			if(!moved)
				SetVelocity(Vector2.Zero)



mob
	icon='TEST/Mob.dmi'
	plane=1
	layer=6

	Enemy
		icon_state="enemy"
		bound_width=17
		bound_height=26



